#!usr/bin/perl

#read words from delete list
$removefile = "./phonics/remove.txt";
open (REM, $removefile);

while($word = <REM>)
{
#takes out front spaces if existing
if ($word =~ /^ /)
	{
	$word = substr($word,1);
	}
chomp($word);
push(@words,$word);
}


#sort alphabetically
@words = sort(@words);

foreach $word (@words)
	{
	@backup = ();
	#read the first letter of the word
	$first = substr($word,0,1);

	#open file with said letter
	open (FILE,"./phonics/".$first.".txt");

	#puts all elements into array
	while ($line = <FILE>)
		{
		chomp($line);
		push(@backup, $line);
		}
	close (FILE);

	open (FILE,">./phonics/".$first.".txt");
	close (FILE);

	open (FILE,">>./phonics/".$first.".txt");
	foreach $item (@backup)
	{
		if($item ne $word)
		{
		print FILE $item."\n";
		}
	}

	close (FILE); 
}

#empty out the damn 
open (REM, ">".$removefile);
close (REM);
