package Bubblegum::Object::Role::Ref;

use Bubblegum::Role 'with';
use Scalar::Util ();

with 'Bubblegum::Object::Role::Defined';

our $VERSION = '0.07'; # VERSION

sub refaddr {
    my $self = bbblgm::chkref CORE::shift;
    return Scalar::Util::refaddr $self;
}

sub reftype {
    my $self = bbblgm::chkref CORE::shift;
    return CORE::ref $self;
}

1;
