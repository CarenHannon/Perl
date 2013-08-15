#!/usr/bin/perl use warnings;
use LWP::Simple;
$skip = 0;$file = "webpage-saved.txt";
$page = 1;

if(!$skip)
{
	while($skip == 0)
	{
		print "page $page \n";
		#loads author page
		$webpage = get("http://www.helium.com/users/353332/show_articles?page=$page");		die "Page is offline or doesn't exist!" unless defined $webpage;
		#cuts out the articles list only
		
		$pos1 = index($webpage, "articlesList");
		$pos2 = index($webpage, "</dl>");
		$length = $pos2-$pos1;
		$webpage = substr($webpage, $pos1, $length);
		if(index($webpage,"<dt>") == -1)
		{
			$skip = 1;
		}
		#saves to file
		if($page == 1)
		{			open (MYFILE, ">".$file);
			print MYFILE $webpage;
			close(MYFILE);
		}
		if($page > 1 && $skip == 0)
		{
			open (MYFILE, ">>".$file);
			print MYFILE "\n::page $page\n\n";
			print MYFILE $webpage;
			close(MYFILE);
		}
		$page++;
	}	
}
#parses page for article links only	
$parsed = "";
open (MYFILE, $file);
while(my $line = <MYFILE>)
{
	if(index($line,"class=\"title\"")!=-1)
	{
		if(index($line,"<em>")!=-1)
		{
			$line = substr($line, 0,index($line,"<em>"));
			$line = "$line";
		}
	$parsed = $parsed.$line;
	}
}
close (MYFILE);


#reprints file
open (MYFILE, ">".$file);
print MYFILE $parsed;
close(MYFILE);

#reparses to tab out into a database/spreadsheet friendly format
$parsed = "";
open (MYFILE, $file);
while(my $line = <MYFILE>)
{
	$url = substr($line,index($line, "href")+6);
	$url = substr($url, 0,index($url, "\""));
	$line = substr($line, index($line,">")+1);
	$line = substr($line, 0, index($line, "<"));
	print "$url \n";
	print "$line \n\n";
	$date = fetchDate($url);
	print $date;
	
	#prints name (line) then url
	$parsed = $parsed."$line\t$url\t$date\n";	
}
close (MYFILE);

#reprints file
open (MYFILE, ">".$file);
print MYFILE $parsed;
close(MYFILE);

sub fetchDate
{
	$webpage = get($url);
	$webpage = substr($webpage, index($webpage,"Created"));
	$webpage = substr($webpage, 0,index($webpage,",")+6);
	$webpage = substr($webpage, index($webpage,":")+2);
	return $webpage;
}



