#!/usr/bin/perl

binmode STDOUT, ":utf8";

if ( $ARGV[0] eq "" ) {
	print "Usage: ./covergrabber.pl \"<Search Term - Album and/or Artist>\"\n";
	exit 1;
}

use LWP::Simple;
#use warnings;

my $searchTerm = $ARGV[0];
$searchTerm =~ s/ /\+/g;

my $searchURL = "http://www.last.fm/search/overview?q=$searchTerm&type=album";

#print "$searchURL\n";

my $baseURL = get($searchURL);
my @parseURL = split("\n", $baseURL);

my $coverCount = 0;

foreach my $line (@parseURL){
	
	if ( $line =~ /albumCover coverMedium/g ) {
		
		my @splitLine = split(" ",$line);
		my $albumEndURL = $splitLine[1];
		$albumEndURL =~ s/\"//g;
		$albumEndURL =~ s/href=//g;
		#print "$albumEndURL\n";
	
		my $albumURL = "http://www.last.fm$albumEndURL";
		#print "$albumURL\n";

		my $basealbumURL = get($albumURL);
		my @parsealbumURL = split("\n", $basealbumURL);

		my @picList = grep(/\+images/,@parsealbumURL);
		
		foreach my $line (@picList){
			(my $pic) = $line =~ /http.*\..../g;
        		$pic =~ s/\n//g;
			if ( $pic ) {
        			my @fileName = split("/",$pic);
				#print "$fileName[-1]\n"; 
				print "Grabbing: $pic\n";	
				getstore("$pic","$fileName[-1]");
				$coverCount++;
			}
		}
	}
}

if ($coverCount == 0){
	print "No Covers Found. Please check network access and/or refine search term\n";
} elsif ($coverCount == 1){
	print "OMG so lonely, Only Downloaded 1 Cover\n";
} else {	
	print "Downloaded $coverCount Covers\n";		
}
