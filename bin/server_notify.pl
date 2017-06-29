#!/usr/bin/perl -w

use strict;
use IO::Socket;
use File::Basename;
use Cwd 'abs_path';
my $scriptpath = dirname(abs_path($0));

my $HOST = '127.0.0.1';
my $PORT = '1216';


my $socket = IO::Socket::INET->new('LocalPort' => $PORT,
    'Proto' => 'tcp',
    'Listen' => 4)
or die "Can't create socket ($!)\n";
while (my $client = $socket->accept) {
  my ($urgency, $title, $summary,$x);
  while (<$client>) {
    my $buf = $_;
    chomp $buf;
    $x++;
    if($x == 1){$urgency = $buf;}
    if($x == 2){$title = $buf;}
    if($x >= 3){
      $summary .= $buf . '\n';
    }
  }
  message($urgency,$title,$summary);
  close $client
    or die "Can't close ($!)\n";
}

sub message{
  my $urgency = $_[0];
  my $title = $_[1];
  my $summary = $_[2];

  $title =~ s/&/&amp;/g;
  $title =~ s/</&lt;/g;
  $title =~ s/>/&gt;/g;
  $summary =~ s/&/&amp;/g;
  $summary =~ s/</&lt;/g;
  $summary =~ s/>/&gt;/g;

  system ('/usr/bin/notify-send', '-u', $urgency, $title, $summary);
}
