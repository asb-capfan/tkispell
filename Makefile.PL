use ExtUtils::MakeMaker;
use English qw'-no_match_vars';

my $ispell_bin = '';

if( $OSNAME eq 'MSWin32' ) {

    # look for aspell first, as it the successor of ispell
    $ispell_bin = `where aspell`;
    
    # fallback: if no aspell is found, look for ispell
    if( !defined $ispell_bin or $ispell_bin eq '' ) {
        $ispell_bin = `where ispell`;
    }
    
}else{

    $ispell_bin = `which aspell`;
    
    # fallback: if no aspell is found, look for ispell
    if( !defined $ispell_bin or $ispell_bin eq '' ) {
        $ispell_bin = `which ispell`;
    }
}

# The first match is for Solaris which.  The second is for 
# Linux which. The 3rd one for Windows.
if( ($ispell_bin =~ /no ispell/) || (length($ispell_bin) == 0 || $ispell_bin !~ m/(?:i|a)spell.exe$/) ) {
    print "Could not find locate ispell or aspell.\n";
    print "Make sure that the program is installed in a directory\n";
    print "named in the PATH environment variable.\n";  
    exit(1);
}

WriteMakefile(
    AUTHOR => 'Robert Kiesling, rkies@cpan.org' ,
	NAME => 'tkispell',
	VERSION_FROM => 'tkispell',
	EXE_FILES => ['tkispell'],
);
