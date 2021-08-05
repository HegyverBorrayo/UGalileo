#!/usr/bin/perl -w
use strict;
use Socket;

my $port = shift || 1850;
my $host = shift || 'localhost';
my $server = shift || 'localhost';
socket(SOCKET_SERVER_NEW,PF_INET,SOCK_STREAM,(getprotobyname('tcp'))[2]) or die "Can't create a socket $!\n";
connect( SOCKET_SERVER_NEW, pack_sockaddr_in($port, inet_aton($server))) or die "Can't connect to port $port! \n";
print "> Connection started on port $port\n";
print SOCKET_SERVER_NEW "GET /test.html HTTP/1.1\n";
print SOCKET_SERVER_NEW "Host: www.galileo.edu\n";
print SOCKET_SERVER_NEW "User-Agent: Mozilla/5.0\n";
print SOCKET_SERVER_NEW "Accept-Language: es,en\n";
print SOCKET_SERVER_NEW "Connection: keep-alive\n";
close SOCKET_SERVER_NEW or die "close: $!";
print "> Connection close\n";