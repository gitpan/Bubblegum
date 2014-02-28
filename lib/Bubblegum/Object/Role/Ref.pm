package Bubblegum::Object::Role::Ref;

use Bubblegum::Role 'with';
use Bubblegum::Syntax -types;

use Scalar::Util ();

with 'Bubblegum::Object::Role::Defined';

our $VERSION = '0.13'; # VERSION

sub refaddr {
    my $self = type_ref CORE::shift;
    return Scalar::Util::refaddr $self;
}

sub reftype {
    my $self = type_ref CORE::shift;
    return CORE::ref $self;
}

1;
