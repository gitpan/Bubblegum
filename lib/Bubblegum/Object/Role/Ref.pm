package Bubblegum::Object::Role::Ref;

use Bubblegum::Role 'with';
use Bubblegum::Syntax -types;

use Scalar::Util ();

with 'Bubblegum::Object::Role::Defined';

our $VERSION = '0.15'; # VERSION

sub refaddr {
    my $self = type_reference CORE::shift;
    return Scalar::Util::refaddr $self;
}

sub reftype {
    my $self = type_reference CORE::shift;
    return CORE::ref $self;
}

1;
