#!usr/bin/perl

#Reads data from file
use LWP::UserAgent;

#sets variables
open(RESULTS,">scan_results.txt");
print RESULTS ("");

close(RESULTS);
$param1 = "www.google.com";
open(KEYWORDS,"+<keywordsfile.txt");

#adds keywords to array
while($line = <KEYWORDS>)
{
push(@keywords,$line);
}

#sets user agent
$ua = new LWP::UserAgent;
$ua -> timeout(30);
$ua -> agent("");

#needs a foreach loop here
foreach $keyword (@keywords)
{

#queries
$url = "http://www.google.com/search?q=$keyword";
#$url = "http://www.google.com/search?q=$keywords[0]";
$response = $ua->get($url);
#error message
if(!($response->is_success)) {
        print ($response->status_line. "<div id=resultStats>     Error! results<nobr> \n"); }
else 
{
        @results = $response->as_string;
        $results= "@results";
}

#parses data
$pos1 = index ($results, "</b> of about <b>");
$pos2 = index ($results, "</b> for <b>");
#$string = $results;
$string = substr($results, $pos1 + 17, ($pos2-($pos1+17)));
print "$string \n";

#opens file to append to
open(RESULTS,">>scan_results.txt");
if(length $string < 50)
{
print RESULTS ("$string\n");
}

}
close(RESULTS);
close(KEYWORDS);
