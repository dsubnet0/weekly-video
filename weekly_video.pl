#!/usr/bin/perl

use v5.10;
use strict;
use warnings;
use Date::Parse;
use Getopt::Long;
use MIME::Lite;
use POSIX qw(strftime);

my %args;
GetOptions(\%args,
    'today',
    'skip-email',
    'date:s'
);

my %video_list = (
    0 => "David Kahn disc 1",
    1 => "David Kahn disc 2",
    2 => "David Kahn disc 3",
    3 => "David Kahn disc 4",
    4 => "David Kahn disc 5",
    5 => "David Kahn disc 6",
    6 => "Nir Maman disc 1",
    7 => "Nir Maman disc 2",
    8 => "Nir Maman disc 3",
    9 => "Nir Maman disc 4",
    10 => "Nir Maman disc 5",
    11 => "Nir Maman disc 6",
    12 => "Nir Maman disc 7",
    13 => '<a href="https://www.youtube.com/watch?v=k_M8eiPOdFQ">Alain Cohen video 1</a>',
    14 => '<a href="https://www.youtube.com/watch?v=NrH8msH3m5s">Alain Cohen video 2</a>',
    15 => '<a href="https://www.youtube.com/watch?v=G-DaiekPzuo">Alain Cohen video 3</a>',
    16 => '<a href="https://www.youtube.com/watch?v=ib12ctWgyBU">Alain Cohen video 4</a>',
    17 => '<a href="https://www.youtube.com/watch?v=4PEtnUaFfVM">Alain Cohen video 5</a>',
    18 => '<a href="https://www.youtube.com/watch?v=K4cNgG_x7K0">Alain Cohen video 6</a>',
    19 => '<a href="https://www.youtube.com/watch?v=cKg6qU8tu00">Best Defense</a>',
    20 => '<a href="https://www.youtube.com/watch?v=bzL0ooWfLQk">First Strike</a>',
    21 => '<a href="https://www.youtube.com/watch?v=I8xctHzFSEI">On the Edge</a>',
    22 => '<a href="https://www.youtube.com/watch?v=u3bH8xLrRNY">Line of Fire</a>',
    23 => "USKMA disc 1"
);

my $target_time = lastSunday();
if (defined $args{'today'}) { $target_time = time; }
if (defined $args{'date'}) { $target_time = str2time($args{'date'}); }
say scalar(localtime) . " - Video for " . scalar(localtime($target_time)) . "\n";

srand(strftime("%Y%m%d",localtime($target_time)));
my $current_video = $video_list{int(rand(scalar(keys %video_list)))};
say $current_video;

my $email = MIME::Lite->new(
    'To'        => "dsubnet0\@gmail.com",
    'Subject'   => "Krav video lesson for ".strftime("%Y%m%d",localtime($target_time)),
    'Type'      => 'text/html',
    'Data'      => $current_video
);
unless (defined $args{'skip-email'}) {
    $email->send() or die "Failed to send";
}


sub lastSunday {
  my $now = time;
  while (scalar localtime($now) !~ m[Sun]) {
    $now -= 43200; 
  }
  return $now;
}
