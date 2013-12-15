package Bubblegum::Object::Scalar;

use Bubblegum 'with';
use Scalar::Util ();

with 'Bubblegum::Object::Role::Value';

sub and {
    my ($self, $other) =  @_;
    return $self && $other;
}

sub not {
    my ($self) =  @_;
    return !$self;
}

sub or {
    my ($self, $other) =  @_;
    return $self || $other;
}

sub repeat {
    my $self   = CORE::shift;
    my $number = bbbl'gm::chknum CORE::shift;
    return $self x $number;
}

sub xor {
    my ($self, $other) =  @_;
    return $self xor $other;
}

1;
