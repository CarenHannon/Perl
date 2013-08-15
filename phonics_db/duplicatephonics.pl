#!usr/bin/perl

use File::Find;
use File::Copy;

$store = "./phonics";
sub filter
{	
	if($_ =~ /^[a-z,A-Z].txt/)
	{
		push(@filenames,$_);
	}
}
File::Find::find(\&filter,"$store");


foreach $location (@filenames)
{
%duplicates = ();
$location = $store."/".$location;
open (DUPE,$location);
while ($word = <DUPE>)
{
$duplicates{$word} = 1;
}
@dupes = sort{$a cmp $b} keys %duplicates;

close (DUPE);
open (DUPE,">$location");
close (DUPE);
open (DUPE,">>$location");
foreach $key (@dupes)
{
print DUPE ("$key");
}
close(DUPE);
}
