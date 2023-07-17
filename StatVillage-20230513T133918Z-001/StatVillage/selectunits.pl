#!/usr/local/bin/perl -- -*-perl-*-

# ------------------------------------------------------------
# selectunits.pl - select units from StatCity
#       29Nov95  - version 1.  C. Schwarz
#        8may96  - use census data now
#
# The www will return a list of sampling units to be selected from 
# StatVillage. This routine will open the StatVillage raw data file, extract
# the records corresponding to the sampling units, and will then
# send them back to the WWW browser as a text file.
#
# It assumes that the form on the WWW browser will send back the list
# of sampling units in sorted order, so there is no need to resort
# after extraction.
# ------------------------------------------------------------


# Start the definition of the page type
# Print out a content-type for HTTP/1.0 compatibility
print "Content-type: text/html\n\n";
print "<html><head><title>Extracted Records</title></head>\n";
print "<body>";

# Print a title and initial heading

print "Here are the results of your survey from StatVillage.";
print "<p>Refer to the <a href=//www.stat.ncsu.edu/info/jse/v5n2/schwarz.supp/codebook.html>codebook</a> for definitions of the variables.";
print " and their definitions";
print "<p>Save this file as a text file using the File menu and the Save options. ";
print "Then strip off the lines before and after the raw data. ";
print "Be sure that the file is saved as a TEXT file.";
print "<p>A <a href=//www.stat.ncsu.edu/info/jse/v5n2/schwarz.supp/sasdatastep.html>SAS data step</a> is available to read your saved file.";
print "<pre>";


# make sure that the raw StatVillage file exists and is a plain file.
$infile= 'StatVillage.raw';

if (! -r $infile) {print "Can't read input $infile\n";die "Help 1";          }
# print ! -r $infile;
if (! -f $infile) {print "Input $infile is not a plain file\n";die "Help 2"; }
# print ! -r $infile;
$open = open(STATCITY,"<$infile");
# print $open;
if (! $open) {print "Can't open the file $infile"; die "Help 4";}
$SC_recnum = 1;


# Get the input from the form on the WWW browser
read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});

# Split the name-value pairs
@pairs = split(/&/, $buffer);  # now looks like an array with each element 'unit=value'
sort @pairs;    # sort by unit number


foreach $pair (@pairs)
{
    ($name, $value) = split(/=/, $pair);   # $value now contains the sampling unit number

    # Un-Webify plus signs and %-encoding
    $value =~ tr/+/ /;
    $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;

    # Stop people from using subshells to execute commands
    # Not a big deal when using sendmail, but very important
    # when using UCB mail (aka mailx).
    # $value =~ s/~!/ ~!/g; 

    # print "Extracting sampling unit $value <br>"; #debugging statement
 
    # now to read the StatVillage file until we get a match with this value.
    while ($SC_recnum < $value) {
        <STATCITY>;
        $SC_recnum = $SC_recnum + 1;
    }
    # now to read the record for this unit and then print to the file
    $in_1 = <STATCITY>;
    chop $in_1;     # remove new line character from end of record
    $SC_recnum = $SC_recnum + 1;
    print "$in_1 \n"; 
   

}

# now to close up
print  "</pre>";
print  "<br>------------------------------------------------------------";
print  "<br>Server protocol: $ENV{'SERVER_PROTOCOL'}\n";
print  "<br>Remote host: $ENV{'REMOTE_HOST'}\n";
print  "<br>Remote IP address: $ENV{'REMOTE_ADDR'}\n";
print  "</body></html>";



close (STATCITY);
