package Bubblegum::Object::Number;

use Bubblegum 'with';

with 'Bubblegum::Object::Role::Value';

sub abs {
    my $self = CORE::shift;
    return CORE::abs $self;
}

sub atan2 {
    my $self = CORE::shift;
    my $x    = bbbl'gm::chknum CORE::shift;
    return CORE::atan2 $self, $x;
}

sub cos {
    my $self = CORE::shift;
    return CORE::cos $self;
}

sub decr {
    my $self = CORE::shift;
    my $n    = bbbl'gm::chknum CORE::shift if $_[0];
    return $self - ($n || 1);
}

sub exp {
    my $self = CORE::shift;
    return CORE::exp $self;
}

sub hex {
    my $self = CORE::shift;
    return CORE::hex $self;
}

sub incr {
    my $self = CORE::shift;
    my $n    = bbbl'gm::chknum CORE::shift if $_[0];
    return $self + ($n || 1);
}

sub int {
    my $self = CORE::shift;
    return CORE::int $self;
}

sub log {
    my $self = CORE::shift;
    return CORE::log $self;
}

sub mod {
    my $self    = CORE::shift;
    my $divisor = bbbl'gm::chknum CORE::shift if $_[0];
    return $self % $divisor;
}

sub neg {
    my $self = CORE::shift;
    return -$self;
}

sub oct {
    my $self = CORE::shift;
    return CORE::oct $self;
}

sub pow {
    my $self = CORE::shift;
    my $n    = bbbl'gm::chknum CORE::shift if $_[0];
    return $self ** $n;
}

sub sin {
    my $self = CORE::shift;
    return CORE::sin $self;
}

sub sqrt {
    my $self = CORE::shift;
    return CORE::sqrt $self;
}

1;
