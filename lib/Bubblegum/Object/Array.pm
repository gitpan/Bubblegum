package Bubblegum::Object::Array;

use Bubblegum 'with';

with 'Bubblegum::Object::Role::Indexed';
with 'Bubblegum::Object::Role::List';
with 'Bubblegum::Object::Role::Ref';
with 'Bubblegum::Object::Role::Defined';

use Syntax::Keyword::Junction::All  ();
use Syntax::Keyword::Junction::Any  ();
use Syntax::Keyword::Junction::None ();
use Syntax::Keyword::Junction::One  ();
use Scalar::Util ();

sub all {
    my $self = CORE::shift;
    return Syntax::Keyword::Junction::All->new(@$self);
}

sub any {
    my $self = CORE::shift;
    return Syntax::Keyword::Junction::Any->new(@$self);
}

sub count {
    goto &length;
}

sub defined {
    my $self  = CORE::shift;
    my $index = bbbl'gm::chknum CORE::shift;

    return CORE::defined $self->[$index];
}

sub delete {
    my $self  = CORE::shift;
    my $index = bbbl'gm::chknum CORE::shift;

    return CORE::delete $self->[$index];
}

sub each {
    my $self = CORE::shift;
    my $code = bbbl'gm::chkcode CORE::shift;

    my $i=0;
    foreach my $value (@$self) {
        $code->($i, $value); $i++;
    }

    return $self;
}

sub each_key {
    my $self = CORE::shift;
    my $code = bbbl'gm::chkcode CORE::shift;

    $code->($_) for [0..$#{$self}];
    return $self;
}

sub each_n_values {
    my $self   = CORE::shift;
    my $number = $_[0] ? bbbl'gm::chknum  CORE::shift : 2;
    my $code   = bbbl'gm::chkcode CORE::shift;
    my @values = @$self;

    $code->(CORE::splice @values, 0, $number) while @values;
    return $self;
}

sub each_value {
    my $self = CORE::shift;
    my $code = bbbl'gm::chkcode CORE::shift;

    $code->($self->[$_]) for [0..$#{$self}];
    return $self;
}

sub empty {
    my $self = CORE::shift;

    $#$self = -1;
    return $self;
}

sub exists {
    my $self  = CORE::shift;
    my $index = bbbl'gm::chknum CORE::shift;
    return CORE::exists $self->[$index];
}

sub first {
    my $self = CORE::shift;
    return $self->[0];
}

sub get {
    my $self  = CORE::shift;
    my $index = bbbl'gm::chknum CORE::shift;
    return $self->[$index];
}

sub grep {
    my $self = CORE::shift;
    my $code = bbbl'gm::chkcode CORE::shift;
    return [CORE::grep { $code->($_) } @$self];
}

sub head {
    my $self = CORE::shift;
    return $self->[0];
}

sub iterator {
    my $self = CORE::shift;

    my $i = 0;
    return sub {
        return undef if $i > $#{$self};
        return $self->[$i++];
    }
}

sub join {
    my $self = CORE::shift;
    my $separator = bbbl'gm::chkstr CORE::shift if $_[0];
    return CORE::join $separator // '', @$self;
}

sub keyed {
    my $self = CORE::shift;
    my @keys = @_;

    bbbl'gm::chkstr $_ for @keys;

    my $i=0;
    return { CORE::map { $_ => $self->[$i++] } @keys };
}

sub keys {
    my $self = CORE::shift;
    return [0 .. $#{$self}];
}

sub last {
    my $self = CORE::shift;
    return $self->[-1];
}

sub length {
    my $self = CORE::shift;
    return CORE::scalar @$self;
}

sub list {
    my $self = CORE::shift;
    return (@$self);
}

sub map {
    my $self = CORE::shift;
    my $code = bbbl'gm::chkcode CORE::shift;
    return [CORE::map { $code->($_) } @$self];
}

sub max {
    my $self = CORE::shift;
    my $max;

    for my $val (@$self) {
        next if CORE::ref($val);
        next if ! CORE::defined($val);
        next if ! Scalar::Util::looks_like_number($val);
        $max //= $val;
        $max = $val if $val > $max;
    }

    return $max;
}

sub min {
    my $self = CORE::shift;
    my $min;

    for my $val (@$self) {
        next if CORE::ref($val);
        next if ! CORE::defined($val);
        next if ! Scalar::Util::looks_like_number($val);
        $min //= $val;
        $min = $val if $val < $min;
    }

    return $min;
}

sub none {
    my $self = CORE::shift;
    return Syntax::Keyword::Junction::None->new(@$self);
}

sub nsort {
    my $self = CORE::shift;
    my $code = sub { $a <=> $b };
    return $self->sort($code);
}

sub one {
    my $self = CORE::shift;
    return Syntax::Keyword::Junction::One->new(@$self);
}

sub pairs {
    goto &pairs_array;
}

sub pairs_array {
    my $self = CORE::shift;
    my $i=0;
    return [CORE::map +[$i++, $_], @$self];
}

sub pairs_hash {
    my $self = CORE::shift;
    my $i=0;
    return {CORE::map {$i++ => $_} @$self};
}

sub pop {
    my $self = CORE::shift;
    return CORE::pop @$self;
}

sub push {
    my $self = CORE::shift;
    my @args = @_;

    CORE::push @$self, @args;
    return $self;
}

sub random {
    my $self = CORE::shift;
    return @$self[rand(@$self)];
}

sub reverse {
    my $self = CORE::shift;
    return [CORE::reverse @$self];
}

sub rotate {
    my $self = CORE::shift;
    CORE::push @$self, CORE::shift @$self;
    return $self;
}

sub rnsort {
    my $self = CORE::shift;
    my $code = sub { $b <=> $a };
    return $self->sort($code);
}

sub rsort {
    my $self = CORE::shift;
    my $code = sub { $b cmp $a };
    return $self->sort($code);
}

sub set {
    my $self  = CORE::shift;
    my $index = bbbl'gm::chknum CORE::shift;
    return $self->[$index] = CORE::shift;
}

sub shift {
    my $self = CORE::shift;
    return CORE::shift @$self;
}

sub size {
    goto &length;
}

sub slice {
    my $self = CORE::shift;
    my @indicies = @_;

    bbbl'gm::chknum $_ for @indicies;

    return [@$self[@indicies]];
}

sub sort {
    my $self = CORE::shift;
    my $code = bbbl'gm::chkcode CORE::shift if $_[0];
    $code ||= sub { $a cmp $b };
    return [CORE::sort { $code->($a, $b) } @$self];
}

sub sum {
    my $self = CORE::shift;
    my $sum  = 0;

    for my $val (@$self) {
        next if CORE::ref($val);
        next if !CORE::defined($val);
        next if !Scalar::Util::looks_like_number($val);
        $sum += $val;
    }

    return $sum;
}

sub tail {
    my $self = CORE::shift;
    return [@$self[1 .. $#$self]];
}

sub unique {
    my $self = CORE::shift;

    my %seen;
    return [CORE::grep { not $seen{$_}++ } @$self];
}

sub unshift {
    my $self = CORE::shift;
    my @args = @_;

    CORE::unshift @$self, @args;
    return $self;
}

sub values {
    my $self = CORE::shift;
    return [@$self];
}

1;
