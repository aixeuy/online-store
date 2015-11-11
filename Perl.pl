#! /usr/bin/perl
use CGI ":standard";

# Declare a subroutine
sub display;

# Get all variables from form
$fname = param('name');
$username = param('user');
$pword = param('pword');
$repword = param('repword');

# Check if all fields are filled
if ($fname eq "" || $username eq "" || $pword eq "" || $repword eq "")
{
  display('nfail');
  exit;
}

# Check if password entries match
if($pword ne $repword || $pword eq "")
{
  display('pfail');
  exit;
}

# Check if the username is already used
open($input, "<Members.csv") or die;

# Read all entries in file
while($line = <$input>)
{
  my @tokens = split(',', $line);

  # If username matches existing one, display with Username Error
  if (@tokens[1] eq $username)
  {
    display("ufail");
    exit;
  }
}

# If no errors, add information to file
close($input);
open(output, ">>Members.csv") or die;
print output "$fname,$username,$pword\n";
close(output);

# Display success page
display;

# Display output to browser based on parameter passed
sub display
{
  # Get parameter
  my $arg = @_[0];

  # Print html based on parameter
  print "Content-Type:text/html\n\n";
  print "<html>\n";
  print "<head>\n";
  print "<title>Universal Real Estate - Registration</title>\n";
  print "</head>\n";
  print "<body bgcolor=\"tan\">\n";
  print "<p style=\"margin-top: 30px;\">\n";

  # If not all entries are filled
  if($arg eq 'nfail')
  {
  print "<h1 align=\"center\">Error: <i>Void Entries</i></h1>\n";
  print "<p align=\"center\"><i>Please fill in every entry before continuing</i><br /><br />\n";
  print "<a href=\"http://www.cs.mcgill.ca/~yxia18/store/home.html\">HOME</a><br /><br />\n";
  print "<a href=\"http://www.cs.mcgill.ca/~yxia18/store/registration.html\">REGISTRATION</a><br /><br />\n";
  print "</p></p>\n";
  print "</body>\n";
  print "</html>";
  }

  # If password doesn't match
  elsif($arg eq 'pfail')
  {
  print "<h1 align=\"center\">Error: <i>Password Mismatch</i></h1>\n";
  print "<p align=\"center\"><i>Please ensure that you match your password entries</i><br /><br />\n";
  print "<a href=\"http://www.cs.mcgill.ca/~yxia18/store/home.html\">HOME</a><br /><br />\n";
  print "<a href=\"http://www.cs.mcgill.ca/~yxia18/store/registration.html\">REGISTRATION</a><br /><br />\n";
  print "</p></p>\n";
  print "<p> </p>";
  print "</body>\n";
  print "</html>";
  }
  
  # If username is taken
  elsif($arg eq 'ufail')
  {
  print "<h1 align=\"center\">Error: <i>Username In-use</i></h1>\n";
  print "<p align=\"center\"><i>Sorry, that username is in use. Please select another one</i><br /><br />\n";
  print "<a href=\"http://www.cs.mcgill.ca/~yxia18/store/home.html\">HOME</a><br /><br />\n";
  print "<a href=\"http://www.cs.mcgill.ca/~yxia18/store/registration.html\">REGISTRATION</a><br /><br />\n";
  print "</p></p>\n";
  print "</body>\n";
  print "</html>";
  }

  # Print successful registratio screen
  else
  {
  print "<h1 align=\"center\">Congratulations!</h1>\n";
  print "<p align=\"center\"><i>You were succesfully registered!</i><br /><br />\n";
  print "<a href=\"http://www.cs.mcgill.ca/~yxia18/store/home.html\">HOME</a><br /><br />\n";
  print "<a href=\"http://www.cs.mcgill.ca/~yxia18/store/login.html\">LOGIN</a><br /><br />\n";
  print "</p>$linecounter</p>\n";
  print "</body>\n";
  print "</html>";
  }
}
