package Bubblegum::Object::Role::List;

use Bubblegum::Role 'requires', 'with';
use Bubblegum::Syntax -types;

with 'Bubblegum::Object::Role::Value';

our $VERSION = '0.13'; # VERSION

requires 'defined';
requires 'grep';
requires 'head';
requires 'join';
requires 'length';
requires 'map';
requires 'reverse';
requires 'sort';
requires 'tail';

sub reduce {
    my $self = CORE::shift;
    my $code = type_cref CORE::shift;
    my $a    = [0 .. $#{$self}];
    my $acc  = $a->head;
    $a->tail->map(sub { $acc = $code->($acc, $_) });
    return $acc;
}

sub zip {
    my $self  = CORE::shift;
    my $other = type_aref CORE::shift;
    my $this  = $self->length < $other->length ? $other : $self;
    my $a     = [0 .. $#{$this}];
    return $this->keys->map(sub { [$self->get($_), $other->get($_)] });
}

1;
