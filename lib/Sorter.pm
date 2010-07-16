package Sorter;

use strict;
use warnings;
use base 'Class::Accessor';

sub values {
    my $self = shift;
    if(@_) {
	$self->{values} = $_[0];
    }
    $self->{values};
}

sub new {
    my $self = shift;
    $self->SUPER::new({values => [], @_});
}

sub set_values {
    my $self = shift;
    $self->values([@_]);
}

sub get_values {
    my $self = shift;
    @{$self->values};
}

sub sort {
    my $self = shift;
    my @values = $self->get_values;
    if(scalar @values <= 1) {
	$self->get_values;
    } else {
	my $root = shift @values;
	
	my @lvals, my @rvals;
	foreach (@values) {
	    ($_ < $root) ? push(@lvals, $_) : push(@rvals, $_); 
        }
	my $lleaf = __PACKAGE__->new;
        my $rleaf = __PACKAGE__->new;
	$lleaf->set_values(@lvals);
	$rleaf->set_values(@rvals);
	$lleaf->sort;
	$rleaf->sort;
	
	$self->set_values($lleaf->get_values, $root, $rleaf->get_values);
    }
}

1;
