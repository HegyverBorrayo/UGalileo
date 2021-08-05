my $json = qq( { "cat" : "Büster" } );   # Str of UCP because of "use utf8"

my $decoder = JSON->new;
my $data = $decoder->decode($json);      # Str of UCP => Hash of str of UCP

say $data->{"cat"};      