package Bubblegum::Object::Role::Ref;

use Bubblegum::Role 'with';
use Scalar::Util ();

with 'Bubblegum::Object::Role::Defined';

sub refaddr {
    my $self = bbbl'gm::chkref CORE::shift;
    return Scalar::Util::refaddr $self;
}

sub reftype {
    my $self = bbbl'gm::chkref CORE::shift;
    return CORE::ref $self;
}

1;
