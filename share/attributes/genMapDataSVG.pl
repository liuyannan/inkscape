#!/usr/bin/env perl

# Purpose: To extract the svgprops data from the
# SVG 1.1 2nd Ed specification file attindex.html. The file can be found at:
#
#   http://www.w3.org/TR/SVG/attindex.html
#
# Note cssprops must be generated first to pickup "Presentation Attributes".

# Author: Tavmjong Bah
# Rewrite of script by Abhishek

use strict;
use warnings;
use HTML::TokeParser;

my $p= HTML::TokeParser->new('attindex.html') or die "Can't open file: $!";

my %attributes;
my $attribute;

# Loop over tokens
while( my $t = $p->get_token ) {

    # Look for <tr> (start token with value 'tr').
    if( $t->[0] eq 'S' and lc $t->[1] eq 'tr') {

	print "---------\n";

	my $column = 0;
	while( $t = $p->get_token ) {

	    # Keep track of column
	    if( $t->[0] eq 'S' and lc $t->[1] eq 'td') {
		$column++;
		$t = $p->get_token; # Skip to next token
	    }

	    if( $column == 1 and $t->[0] eq 'S' and lc $t->[1] =~ 'span') {
		# First column is always attribute name, defined inside <span>.
		$t = $p->get_token;
		$attribute = $t->[1];
		$attribute =~ s/‘//; # Opening single quote
		$attribute =~ s/’//; # Closing single quote
		print "Attribute: $attribute\n";
	    }

	    if( $column == 2 and $t->[0] eq 'S') {
		# Second column is list of elements, each inside its own span.
		if( lc $t->[1] eq 'span' && ${$t->[2]}{'class'} =~ 'element-name' ) {
		    $t = $p->get_token;
		    my $element = $t->[1];
		    $element =~ s/‘//; # Opening single quote
		    $element =~ s/’//; # Closing single quote
		    print "  Elements: $element\n";
		    push @{$attributes{ $attribute }->{elements}}, $element;
		} else {
#		    print "  Not Elements: $t->[1]\n";
		}
	    }

	    if( $t->[0] eq 'E' and lc $t->[1] eq 'tr') {
		last;
	    }

	}
    }

    # Stop if we get to presentation attributes
    if( $t->[0] eq 'S' and lc $t->[1] eq 'h2') {
	$t = $p->get_token;
	if( $t->[1] =~ /Presentation/ ) {
	    print "Found: $t->[1], quiting.\n";
	    last;
	}
    }
}

# Adjustments
push @{$attributes{ "in" }->{elements}}, "feMergeNode";
push @{$attributes{ "class" }->{elements}}, "flowRoot","flowPara","flowSpan","flowRect","flowRegion";
push @{$attributes{ "id"    }->{elements}}, "flowRoot","flowPara","flowSpan","flowRect","flowRegion";
push @{$attributes{ "style" }->{elements}}, "flowRoot","flowPara","flowSpan","flowRect","flowRegion";
push @{$attributes{ "xml:space" }->{elements}}, "flowRoot","flowPara","flowSpan";



# Output

open( ELEMENTS, ">svgprops_new" ) or die "Couldn't open output";

for $attribute ( sort keys %attributes ) {

    print ELEMENTS "\"$attribute\" - ";
    my $first = 0;
    foreach (@{$attributes{ $attribute }->{elements}}) {
	if( $first != 0 ) {
	    print ELEMENTS ",";
	}
	$first = 1;
	print ELEMENTS "\"$_\"";
    }
    print ELEMENTS "\n\n";
}

# Copy cssprops verbatim. For every CSS property there is a
# corresponding "Presentation Attribute".

open( PROPERTIES, "cssprops" ) or die "Couldn't open $!";

while( <PROPERTIES> ) {
    print ELEMENTS;
}
