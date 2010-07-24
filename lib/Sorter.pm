package Sorter;

use strict;
use warnings;
use base 'Class::Accessor';
Sorter->mk_accessors(qw(values));

sub new {
    my $self = shift;
    $self->SUPER::new({values=>[]});
}

sub set_values {
    my $self = shift;
    $self->values([@_]);
    $self;
}

sub get_values {
    my $self = shift;
    @{$self->values};
}

sub sort { &_sort->get_values; }

sub _sort {
    my $self = shift;
    my @values = $self->get_values;
    my $root = shift @values;
    $self->set_values (
	__PACKAGE__->new->set_values(grep {$_ < $root} @values)->_sort->get_values,
	$root,
	__PACKAGE__->new->set_values(grep {$_ >= $root} @values)->_sort->get_values
	) if scalar @values;
    $self;
}

1;
