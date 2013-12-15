package Bubblegum::Object::Integer;

use Bubblegum 'with';

with 'Bubblegum::Object::Role::Defined';
with 'Bubblegum::Object::Role::Comparison';
with 'Bubblegum::Object::Role::Coercive';
with 'Bubblegum::Object::Role::Value';

sub downto {
    my $self = CORE::shift;
    my $other = bbbl'gm::chknum CORE::shift;

    return [CORE::reverse $other..$self];
}

sub eq {
    my $self  = CORE::shift;
    my $other = bbbl'gm::chknum CORE::shift;

    return $self == $other ? 1 : 0;
}

sub eqtv {
    my $self  = CORE::shift;
    my $other = CORE::shift;

    return 0 if !CORE::defined $other;
    return ($self->type eq $other->type && $self == $other) ? 1 : 0;
}

sub gt {
    my $self  = CORE::shift;
    my $other = bbbl'gm::chknum CORE::shift;

    return $self > $other ? 1 : 0;
}

sub gte {
    my $self  = CORE::shift;
    my $other = bbbl'gm::chknum CORE::shift;

    return $self >= $other ? 1 : 0;
}

sub lt {
    my $self  = CORE::shift;
    my $other = bbbl'gm::chknum CORE::shift;

    return $self < $other ? 1 : 0;
}

sub lte {
    my $self  = CORE::shift;
    my $other = bbbl'gm::chknum CORE::shift;

    return $self <= $other ? 1 : 0;
}

sub ne {
    my $self  = CORE::shift;
    my $other = bbbl'gm::chknum CORE::shift;

    return $self != $other ? 1 : 0;
}

sub to {
    my $self  = CORE::shift;
    my $range = bbbl'gm::chknum CORE::shift;

    return [$self..$range] if $self <= $range;
    return [CORE::reverse($range..$self)];
}

sub to_array {
    my $self = CORE::shift;
    return [$self];
}

sub to_code {
    my $self = CORE::shift;
    return sub {$self};
}

sub to_hash {
    my $self = CORE::shift;
    return {$self=>$self};
}

sub to_integer {
    my $self = CORE::shift;
    return $self;
}

sub to_string {
    my $self = CORE::shift;
    return "$self";
}

sub upto {
    my $self = CORE::shift;
    my $other = bbbl'gm::chknum CORE::shift;

    return [$self..$other];
}

1;
