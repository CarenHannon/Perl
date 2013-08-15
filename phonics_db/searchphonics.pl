#!usr/bin/perl

use File::Find;
use File::Copy;
#asks for search term
print ("\n\tEnter Your Search Term\n
	^ beginning	$ ending
	| or	+ 1 or more	? 0 or more
	a{m} m as	a{m,} at least m as
	a{m,n} at least m but at most n as 
	a.c a, 1+letters, then c\n");
chomp($search = <>);
$store = "./phonics";

open (RESULTSFILE, ">".$store."/searchresults.txt");
print RESULTSFILE ("");
close (RESULTSFILE);


#finds a file
sub filter
{	
	if($_ =~ /^[a-z,A-Z].txt/)
	{
		push(@filenames,$_);
		#print ("$_\n");
	}
}
File::Find::find(\&filter,"$store");

foreach $location (@filenames)
	{

open (SEARCHFILE, "+<".$store."/$location");

while($word = <SEARCHFILE>)
{
	if ($word =~ /$search/)
	{
	open (RESULTSFILE, ">>".$store."/searchresults.txt");
	print RESULTSFILE ("$word");
	close (RESULTSFILE);
	}
}


close (SEARCHFILE);
}

