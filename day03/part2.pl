use strict;
## Load input.txt.
open F, '<', 'input.txt'
    or die "Cannot open input.txt ($!)";
my @input = [];
while(<F>){ ## We read line by line (default seperator) to separate wires without any additional code.
    my $list = [];
    my @line = grep /[^\s]+/, (split ',', $_);
    foreach my $i (@line){
        push @$list, $i;
    }
    push @input, $list;
}
@input = grep { scalar @$_ > 0 } @input; ## Filter out empty arrays, since new lines and the start of the file can create them.
close F; ## Close the file because we are polite.

my @instructions = (); ## Now I'm actually processing input into instruction sets.
foreach my $i (@input){
    my $wire = [];
    foreach(@$i){
        my $instruction = substr $_, 0, 1;
        my $value = 0 + substr $_, 1;
        push @$wire, [$instruction, $value]; ## Important to use an array here, not a list or iterable array, to prevent it from being unpacked.
    }
    push @instructions, $wire;
}

my @grids = (); 
foreach(@instructions){ ## Actually start processing. Each instruction adds a line with vertical and horizontal bounds to its own "grid".
    my $grid = [];
    my $x = 0;
    my $y = 0;
    foreach(@$_){
        my $instruction = @$_[0];
        my $value = @$_[1];
        if($instruction eq 'R') { 
            push @$grid, [$x, $x + $value, $y, $y];
            $x += $value;
        } elsif($instruction eq 'L') { 
            push @$grid, [$x, $x - $value, $y, $y];
            $x -= $value;
        } elsif($instruction eq 'U') { 
            push @$grid, [$x, $x, $y, $y + $value];
            $y += $value;
        } elsif($instruction eq 'D') { 
            push @$grid, [$x, $x, $y, $y - $value];
            $y -= $value;
        }
    }
    push @grids, $grid;
}

sub orientation {
    my $xa1 = @_[0];
    my $ya1 = @_[1];
    my $xa2 = @_[2];
    my $ya2 = @_[3];
    my $xb1 = @_[4];
    my $yb1 = @_[5];

    return  (($ya2 - $ya1) * ($xb1 - $xa1) - ($xa2 - $xa1) * ($yb1 - $ya1)) <=> 0;
}

sub intersects {    ## Basic line intersection subroutine. Simplified a bit because I presume these intersections aren't on edges.
    my $xa1 = @_[0];
    my $ya1 = @_[1];
    my $xa2 = @_[2];
    my $ya2 = @_[3];
    my $xb1 = @_[4];
    my $yb1 = @_[5];
    my $xb2 = @_[6];
    my $yb2 = @_[7];

    my $o1 = orientation $xa1, $ya1, $xa2, $ya2, $xb1, $yb1;
    my $o2 = orientation $xa1, $ya1, $xa2, $ya2, $xb2, $yb2;
    my $o3 = orientation $xb1, $yb1, $xb2, $yb2, $xa1, $ya1;
    my $o4 = orientation $xb1, $yb1, $xb2, $yb2, $xa2, $ya2;

    if($o1 != $o2 && $o3 != $o4) {
        my $aa = $ya2 - $ya1;
        my $ba = $xa2 - $xa1;
        my $ca = ($aa * $xa1) + ($ba * $ya1);
        my $ab = $yb2 - $yb1;
        my $bb = $xb2 - $xb1;
        my $cb = ($ab * $xb1) + ($bb * $yb1);
        my $d = ($aa*$bb) - ($ab*$ba);
        my $x = (($bb*$ca) - ($ba*$cb))/$d;
        my $y = (($aa*$cb) - ($ab*$ca))/$d;
        return [$x, $y];
    }
    return 0;
}

my @closest;
my $distance;
my %intersections = ();
foreach my $grid (@grids) {
    my $wire = 0;
    foreach my $l (@$grid) {
        foreach (@grids) {
            if($_ ne $grid){
                foreach(@$_) {
                    my $i = intersects (@$l[0], @$l[2], @$l[1], @$l[3], @$_[0], @$_[2], @$_[1], @$_[3]);
                    if($i ne 0 && (@$i[0] != 0 || @$i[1] != 0) ){
                        my $d = $wire + abs(@$l[0] - @$i[0]) + abs(@$l[2] - @$i[1]);
                        if($d>0){
                            print "Intersection at @$i[0], @$i[1] - $d\n";
                            $intersections{"@$i[0], @$i[1]"} //= 0;
                            $intersections{"@$i[0], @$i[1]"} += $d;
                        }
                        if( (!defined $distance || $d < $distance) && (@$i[0] != 0 || @$i[1] != 0) ) {
                            @closest = @$i;
                            $distance = $d;
                        }
                    }
                }
            }
        }
        my $add = abs(@$l[0] - @$l[1]) + abs(@$l[2] - @$l[3]);
        $wire += $add;
    }
    print "\n";
}

my $closestString;
undef $distance;
foreach my $key(keys %intersections){
    my $value = $intersections{$key};
    if(!defined $distance || $value<$distance) {
        $closestString = $key;
        $distance = $value;
    }
}

print "Closest intersection is at $closestString (distance $distance)";
