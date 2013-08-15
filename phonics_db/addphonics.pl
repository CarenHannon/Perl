#!usr/bin/perl

#adds unadded words to system
$addfile = "./phonics/add.txt";
open (ADD, $addfile);

while($word = <ADD>)
{
#takes out front spaces if existing
if ($word =~ /^ /)
	{
	$word = substr($word,1);
	}
$first = substr($word,0,1);
print("\nTest: Word equals $word");
print("\tFirst Letter: $first");

#open the file by first letter
open (FILE,">>./phonics/".$first.".txt");
print FILE ("$word");
close(FILE);
}

close(ADD);


open (ADD, ">".$addfile);
print ADD (" ");
close (ADD);
