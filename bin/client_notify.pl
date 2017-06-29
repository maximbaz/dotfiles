#!/usr/bin/perl -w

use IO::Socket::INET;
use strict;

my $HOST = '127.0.0.1';
my $PORT = '1216';

my $urgency = shift || $ARGV[0];
my $title = shift || $ARGV[1];
my $summary  = shift || $ARGV[2];


my $sock = IO::Socket::INET->new('PeerAddr' => $HOST,
    'PeerPort' => $PORT,
    'Proto' => 'tcp')
or exit;

$sock->autoflush(1);

if($urgency && $title && $summary){
  print $sock $urgency."\n";
  print $sock $title."\n";
  print $sock $summary."\n";
}

close $sock
