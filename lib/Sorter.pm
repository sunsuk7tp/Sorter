package Sorter;

use strict;
use warnings;
use base 'Class::Accessor::Fast';
Sorter->mk_accessors(qw(values));

sub new { shift->SUPER::new({values=>[]}); }

sub set_values {
    my $self = shift;
    $self->values([@_]);
    $self;
}

sub get_values { @{shift->values}; }

sub sort { &_sort->get_values; }

sub _sort {
    my $self = shift;
    my @values = $self->get_values;
    my $root = splice(@values, int(@values/2), 1);
    return $self->set_values (
	__PACKAGE__->new->set_values(grep {$_ < $root} @values)->_sort->get_values,
	$root,
	__PACKAGE__->new->set_values(grep {$_ >= $root} @values)->_sort->get_values
	) if @values;
    $self;
}

1;
