#!/usr/bin/perl -w
use strict;
use Socket;
use warnings;
use threads;
use threads::shared;
use bytes;


my $server = shift || "localhost";
my $port = shift || 1855;
my $maxThread_console = shift || 5;

#cantidad de threads que wa tener
my $threads_max :shared = $maxThread_console;

my $proto = getprotobyname('tcp');
my $content = "";
socket(SOCKET, PF_INET, SOCK_STREAM, $proto) or die "Can't open socket $!\n";
setsockopt(SOCKET, SOL_SOCKET, SO_REUSEADDR, 1) or die "Can't set socket option to SO_REUSEADDR $!\n";
bind( SOCKET, pack_sockaddr_in($port, inet_aton($server))) or die "Can't bind to port $port! \n";
listen(SOCKET, 5) or die "listen: $!";
print "> Server started on port $port\n";

sub threaded_task {
    threads->create(sub { 
        my $thr_id = threads->self->tid; # GET ID THREAD

        #decrementar
        $threads_max = $threads_max - 1;


        #########################--------------------------
        ##########
        accept(SOCKET_CLIENT_NEW, SOCKET);
        my $socket_cliente = <SOCKET_CLIENT_NEW>;

        my $content = "";

        my @request = split(/\s+/, $socket_cliente);
        my $metodo = $request[0];
        my $name_file;

        my $path_request = $request[1];
        if($metodo eq "GET"){
            $name_file = $path_request;
            #print "name_file1:: $name_file\n";

            if($name_file eq "/"){
                $name_file = "www/index.html";
            } else {
                $name_file = "www/".$name_file;
            }

            #print "name_file2:: $name_file\n";

            my @file_mime = split(/\.+/, $path_request);
            my $aux_path = $path_request;
            $aux_path =~ s/assets\/css\///;
            $aux_path =~ s/assets\/js\///;
            $aux_path =~ s/assets\/img\/portfolio\///;
            $aux_path =~ s/assets\/img\///;
            $aux_path =~ s/\///;
            #print "path_request:: $path_request\n";
            my $mime_request = $file_mime[1];

            #default value
            my $mime_type = "";
            
            #Validando a donde ira a caer
            if(($aux_path =~ "png") == 1) {
                $mime_type = "image/png";
            } elsif(($aux_path =~ "css") == 1) {
                $mime_type = "text/css";
            } elsif(($aux_path =~ "js") == 1) {
                $mime_type = "text/javascript";
            } elsif(($aux_path =~ "woff") == 1) {
                $mime_type = "font/woff2";
            } elsif(($aux_path =~ "ttf") == 1) {
                $mime_type = "font/ttf";
            } else {
                $mime_type = "text/html";
            }

            #quitando parametros del nombre si los trae
            my @new_name_file = split(/\?+/, $name_file);
            $name_file = $new_name_file[0];
            
            if(open(my $file_content, '<', $name_file)){
                while (my $linea = <$file_content>) {
                    $content = $content . $linea;
                }
                print SOCKET_CLIENT_NEW "HTTP/1.1 200 OK\r\n";
                print SOCKET_CLIENT_NEW "Date: Guatemala hoy\r\n";
                print SOCKET_CLIENT_NEW "Content-Type: $mime_type\r\n";
                print SOCKET_CLIENT_NEW "Connection: keep-alive\r\n";
                my $length_line = bytes::length($content);
                #print "name_file:: $name_file";
                #print "length_line:: $length_line";
                print SOCKET_CLIENT_NEW "Content-Length: $length_line\r\n"; 
                print SOCKET_CLIENT_NEW "\r\n";
                print SOCKET_CLIENT_NEW $content;
                close $file_content;
                close SOCKET_CLIENT_NEW;
                print "> Connection close\n";
            } else {
                #aqui retorna que esta dando error
                #print "esta dando dando error"
            }
        } elsif($metodo eq "POST"){
            my $socket_header = <SOCKET_CLIENT_NEW>;
            my $length_body_form;
            my @info_length;
            my $content_type;
            while ($socket_header ne "\r\n"){
                #chomp $socket_header;
                #print "$socket_header\n";
                
                if ($socket_header =~ "Content-Length") {
                    #Content-Length: number
                    @info_length = split(/\:/, $socket_header);
                    $length_body_form = $info_length[1];
                }

                if ($socket_header =~ "Content-Type") {
                    my @info_content_type = split(/\:/, $socket_header);
                    $content_type = $info_content_type[1];
                    #print "no entraaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
                    #print "content_type:: $content_type";
                    $content_type =~ s/ //g;
                }

                $socket_header = <SOCKET_CLIENT_NEW>;
            }

            print "( $content_type )";

            if ($content_type =~ "application/x-www-form-urlencoded") {
                #leer los parametros que esta mandando la pagina
                read(SOCKET_CLIENT_NEW, my $body_form, $length_body_form);
                #print "$body_form \n";

                my @params_form  = split(/\&/ ,$body_form);
                my $name = $params_form[0];
                my $email = $params_form[1];
                my $subject = $params_form[2];
                my $massage = $params_form[3];

                my @values_name  = split(/\=/ ,$name);
                my $value_name = $values_name[1];
                $value_name =~ s/\+/ /g;

                my @values_email  = split(/\=/ ,$email);
                my $value_email = $values_email[1];
                $value_email =~ s/%40/@/g;

                my @values_subject  = split(/\=/ ,$subject);
                my $value_subject = $values_subject[1];
                $value_subject =~ s/\+/ /g;

                my @values_massage  = split(/\=/ ,$massage);
                my $value_massage = $values_massage[1];
                $value_massage =~ s/\+/ /g;
                
                my $file_content_response = "www/PrimerTest.cc8";
                my $content_response = "";
                if(open(my $file_content_response, '<', $file_content_response)){
                    while (my $linea_response = <$file_content_response>) {
                        $content_response = $content_response . $linea_response;
                    }
                    $content_response =~ s/{name}/$value_name/g;
                    $content_response =~ s/{email}/$value_email/g;
                    $content_response =~ s/{subject}/$value_subject/g;
                    $content_response =~ s/{massage}/$value_massage/g;

                    print SOCKET_CLIENT_NEW "HTTP/1.1 200 OK\r\n";
                    print SOCKET_CLIENT_NEW "Date: Guatemala hoy\r\n";
                    print SOCKET_CLIENT_NEW "Content-Type: text/html\r\n";
                    print SOCKET_CLIENT_NEW "Connection: keep-alive\r\n";
                    my $length_line = bytes::length($content_response);
                    print SOCKET_CLIENT_NEW "Content-Length: $length_line\r\n"; 
                    print SOCKET_CLIENT_NEW "\r\n";
                    print SOCKET_CLIENT_NEW $content_response;
                    close $file_content_response;
                    close SOCKET_CLIENT_NEW;
                    print "> Connection close\n";
                }
            } elsif($content_type =~ "application/json"){
                #print ">>>>no holis";
                
                close SOCKET_CLIENT_NEW;
                print "> Connection close\n";
            }


        } else {
            print "holaaaaaaaaaaaa <---";
        }
        ###########################------------------------


        print "Starting thread $thr_id \n";
        print "Ending thread $thr_id\n";

        #aumentar
        $threads_max = $threads_max + 1;

        threads->detach(); #END THREAD
    });
}

while (1)
{
    #validamos si existen disonibles
    if($threads_max > 0){
        threaded_task();
    }
    #sleep 1;
}