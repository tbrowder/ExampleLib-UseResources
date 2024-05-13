use Test;

use ExampleLib::UseResources;
use File::Temp;

my $debug = 0;

# exercise loading the example in resources
my %rpaths = get-resources-hash;
if $debug {
    say "DEBUG: \%rpaths:";
    my @k = %rpaths.keys.sort;
    for @k -> $k {
        my $f = %rpaths{$k};
        say "  $f";
        my $s = get-content $f;
        say "    contents: ", $s;
    }
    say "DEBUG: early exit"; exit;
}

my $eg     = "zz-UseResources.t";
my $eg-path;
if %rpaths{$eg}:exists {
   $eg-path = %rpaths{$eg}
}
else {
    die "FATAL: \$eg-path is undefined";
}

my $istr = get-content $eg-path;
lives-ok {
    for $istr.lines -> $line {
        say "line: $line"
    }
}, "contentents of dir 'resources'";

# check downloading resource files
my $tdir;
if $debug {
    $tdir = './tmp';
    mkdir $tdir;
}
else {
    $tdir = tempdir;
}
chdir $tdir;

lives-ok {
    show-resources;
}

lives-ok {
    download-resources;
}

done-testing;
