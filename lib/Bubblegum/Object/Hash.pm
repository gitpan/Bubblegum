package Bubblegum::Object::Hash;

use Bubblegum 'with';

with 'Bubblegum::Object::Role::Defined';
with 'Bubblegum::Object::Role::Keyed';
with 'Bubblegum::Object::Role::Ref';

sub aslice {
    goto &array_slice;
}

sub array_slice {
    my $self = CORE::shift;
    my @keys = map { bbbl'gm::chkstr $_ } @_;
    return [@{$self}{@keys}];
}

sub defined {
    my $self = CORE::shift;
    my $key  = bbbl'gm::chkstr CORE::shift;
    return CORE::defined $self->{$key};
}

sub delete {
    my $self = CORE::shift;
    my $key  = bbbl'gm::chkstr CORE::shift;
    return CORE::delete $self->{$key};
}

sub each {
    my $self = CORE::shift;
    my $code = bbbl'gm::chkcode CORE::shift;

    for my $key (CORE::keys %$self) {
      $code->($key, $self->{$key});
    }

    return $self;
}

sub each_key {
    my $self = CORE::shift;
    my $code = bbbl'gm::chkcode CORE::shift;

    $code->($_) for CORE::keys %$self;
    return $self;
}

sub each_n_values {
    my $self   = CORE::shift;
    my $number = $_[0] ? bbbl'gm::chknum CORE::shift : 2;
    my $code   = bbbl'gm::chkcode CORE::shift;

    my @values = CORE::values %$self;
    $code->(CORE::splice @values, 0, $number) while @values;
    return $self;
}

sub each_value {
    my $self = CORE::shift;
    my $code = bbbl'gm::chkcode CORE::shift;

    $code->($_) for CORE::values %$self;
    return $self;
}

sub empty {
    my $self = CORE::shift;
    CORE::delete @$self{CORE::keys%$self};
    return $self;
}

sub exists {
    my $self = CORE::shift;
    my $key  = bbbl'gm::chkstr CORE::shift;
    return CORE::exists $self->{$key};
}

sub filter_exclude {
    my $self = CORE::shift;
    my @keys = map { bbbl'gm::chkstr $_ } @_;
    my %i    = map { $_ => bbbl'gm::chkstr $_ } @keys;

    return {CORE::map { CORE::exists $self->{$_} ? ($_ => $self->{$_}) : () }
        CORE::grep { not CORE::exists $i{$_} } CORE::keys %$self};
}

sub filter_include {
    my $self = CORE::shift;
    my @keys = map { bbbl'gm::chkstr $_ } @_;

    return {CORE::map { CORE::exists $self->{$_} ? ($_ => $self->{$_}) : () }
        @keys};
}

sub get {
    my $self = CORE::shift;
    my $key  = bbbl'gm::chkstr CORE::shift;
    return $self->{$key};
}

sub hash_slice {
    my $self = CORE::shift;
    my @keys = map { bbbl'gm::chkstr $_ } @_;
    return {CORE::map { $_ => $self->{$_} } @keys};
}

sub hslice {
    goto &hash_slice;
}

sub invert {
    my $self = CORE::shift;
    my $temp = {};
    $temp->{CORE::delete $self->{$_}} = $_ for CORE::keys %$self;
    $self->{$_} = CORE::delete $temp->{$_} for CORE::keys %$temp;
    return $self;
}

sub iterator {
    my $self = CORE::shift;
    my @keys = map { bbbl'gm::chkstr $_ } @_;

    my $i = 0;
    return sub {
        return undef if $i > $#keys;
        return $self->{$keys[$i++]};
    }
}

sub keys {
    my $self = CORE::shift;
    return [CORE::keys %$self];
}

sub lookup {
    my $self = CORE::shift;
    my $key  = bbbl'gm::chkstr CORE::shift;
    my @keys = CORE::split /\./, $key;
    my $node = $self;
    for my $key (@keys) {
        if ('HASH' eq CORE::ref $node) {
            return undef unless CORE::exists $node->{$key};
            $node = $node->{$key};
        }
        else {
            return undef;
        }
    }
    return $node;
}

sub pairs {
    goto &pairs_array;
}

sub pairs_array {
    my $self = CORE::shift;
    return [CORE::map { [ $_, $self->{$_} ] } CORE::keys %$self];
}

sub list {
    my $self = CORE::shift;
    return %$self;
}

sub merge {
    my $self = CORE::shift;
    my $hash = bbbl'gm::chkhash CORE::shift;
    return {%$self, %$hash};
}

sub print {
    my $self = CORE::shift;
    return CORE::print %$self;
}

sub reset {
    my $self = CORE::shift;
    @$self{CORE::keys%$self}=();
    return $self;
}

sub reverse {
    my $self = CORE::shift;
    return {CORE::reverse %$self};
}

sub say {
    my $self = CORE::shift;
    return CORE::print %$self, "\n";
}

sub set {
    my $self = CORE::shift;
    my $key  = bbbl'gm::chkstr CORE::shift;
    return $self->{$key} =  CORE::shift;
}

sub values {
    my $self = CORE::shift;
    return [CORE::values %$self];
}

1;
