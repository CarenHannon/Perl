#!usr/bin/perl

#needs to locate a file
use File::Find;
use File::Copy;
$store = "/home/caren/Downloads";
#filters file and assigns url
sub filter
{	if($_ =~/^keyword_ideas/)
	{
		push(@filenames,$_);
		print "$_\n";
	}
}

#File::Find::find(\&filter,"./files");
File::Find::find(\&filter,"$store");

foreach $location (@filenames)
	{
	#opens xml file
	#if(!open(CSVFILE,"files/$csvfile"))
	if(!open(CSVFILE,$store."/".$location))
	{
	die("\n\nFINISHED\n No more files left!\n");
	};


	#opens file to append to
	open (REGULATED,">>files/regulated.csv");

	#reads necessary columns of the file and appends to regulation file

	$first = 1;
	while($line = <CSVFILE>)
	{
	if($first !=1)
	{
	@tabs = split(/\t/,$line);
	splice(@tabs,5);
	$line=join("\t",@tabs);
	@tabs = split(//,$line);
	$line = ("@tabs");
	$line =~ s/(.)\s/$1/seg;

	print REGULATED ("$line\n");
	}
	else
	{
	$first--;
	}

	}

	close(REGULATED);

	#moves file to new folder
	move($store."/".$location,"files/finished/$location");
	close(CSVFILE);
}
