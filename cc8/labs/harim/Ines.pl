#!/usr/bin/perl -w
use strict;
use Socket;

my $server = shift || "localhost";
my $port = shift || 1850;
my $proto = getprotobyname('tcp');
socket(SOCKET, PF_INET, SOCK_STREAM, $proto) or die "Can't open socket $!\n";
setsockopt(SOCKET, SOL_SOCKET, SO_REUSEADDR, 1) or die "Can't set socket option to SO_REUSEADDR $!\n";
bind( SOCKET, pack_sockaddr_in($port, inet_aton($server))) or die "Can't bind to port $port! \n";
listen(SOCKET, 5) or die "listen: $!";
print "> Server started on port $port\n";
accept(SOCKET_CLIENT_NEW, SOCKET);
while (my $recd = <SOCKET_CLIENT_NEW>) {
       print SOCKET_CLIENT_NEW "HTTP/1.1 200 OK\r\n";
       print SOCKET_CLIENT_NEW "Date: Guatemala\r\n";
       print SOCKET_CLIENT_NEW "Content-Type: text/html\r\n";
       print SOCKET_CLIENT_NEW "Connection: keep-alive\r\n";
       print SOCKET_CLIENT_NEW "Content-Length: 29\r\n"; 
       print SOCKET_CLIENT_NEW "\r\n";
       print SOCKET_CLIENT_NEW "<html>INES ALARCON AAAAAAAAAAAAAAAAAAAAAA</html>\r\n";
       close SOCKET_CLIENT_NEW;
}

close SOCKET_CLIENT_NEW;
print "> Connection close\n";