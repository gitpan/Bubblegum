package Bubblegum::Object::Role::Coercive;

use 5.10.0;
use namespace::autoclean;
use Carp ();
use Data::Dumper ();

use Bubblegum::Role 'requires';

our $VERSION = '0.38'; # VERSION

my $coercable = {
    'UNDEF' => {
        'UNDEF'  => sub { $_[0] },
        'CODE'   => sub { my $this = $_[0]; sub { $this } },
        'NUMBER' => sub { 0 },
        'HASH'   => sub { +{} },
        'ARRAY'  => sub { [undef] },
        'STRING' => sub { "" },
    },
    'CODE' => {
        'UNDEF'  => sub { undef },
        'CODE'   => sub { $_[0] },
        'ARRAY'  => sub { [$_[0]] },
        'NUMBER' => sub { Carp::confess 'Not able to coerce code to number' },
        'HASH'   => sub { Carp::confess 'Not able to coerce code to hash' },
        'STRING' => sub { Carp::confess 'Not able to coerce code to string' },
    },
    'NUMBER' => {
        'UNDEF'  => sub { undef },
        'CODE'   => sub { my $this = $_[0]; sub { $this } },
        'NUMBER' => sub { $_[0] },
        'HASH'   => sub { +{ $_[0] => 1 } },
        'ARRAY'  => sub { [$_[0]] },
        'STRING' => sub { "$_[0]" },
    },
    'HASH' => {
        'UNDEF'  => sub { undef },
        'CODE'   => sub { sub { $_[0] } },
        'NUMBER' => sub { keys %{$_[0]} },
        'HASH'   => sub { $_[0] },
        'ARRAY'  => sub { [$_[0]] },
        'STRING' => sub { Data::Dumper->new([$_[0]])->Indent(0)
                            ->Sortkeys(1)->Terse(1)->Dump },
    },
    'ARRAY' => {
        'UNDEF'  => sub { undef },
        'CODE'   => sub { my $this = $_[0]; sub { $this } },
        'NUMBER' => sub { scalar @{$_[0]} },
        'HASH'   => sub { +{ (@{$_[0]} % 2) ? (@{$_[0]}, undef) : @{$_[0]} } },
        'ARRAY'  => sub { $_[0] },
        'STRING' => sub { Data::Dumper->new([$_[0]])->Indent(0)
                            ->Sortkeys(1)->Terse(1)->Dump },
    },
    'STRING' => {
        'UNDEF'  => sub { undef },
        'CODE'   => sub { my $this = $_[0]; sub { $this } },
        'NUMBER' => sub { 0 + (join('', $_[0] =~ /[\d\.]/g) || 0) },
        'HASH'   => sub { +{ $_[0] => 1 } },
        'ARRAY'  => sub { [$_[0]] },
        'STRING' => sub { $_[0] },
    }
};

$coercable->{INTEGER} = $coercable->{NUMBER};
$coercable->{FLOAT}   = $coercable->{NUMBER};

sub to_array {
    my $self = shift;
    my $coerce = 'ARRAY';
    return unless my $type = $self->type;
    return $coercable->{$type}{$coerce}->($self);
}

sub to_code {
    my $self = shift;
    my $coerce = 'CODE';
    return unless my $type = $self->type;
    return $coercable->{$type}{$coerce}->($self);
}

sub to_hash {
    my $self = shift;
    my $coerce = 'HASH';
    return unless my $type = $self->type;
    return $coercable->{$type}{$coerce}->($self);
}

sub to_number {
    my $self = shift;
    my $coerce = 'NUMBER';
    return unless my $type = $self->type;
    return $coercable->{$type}{$coerce}->($self);
}

sub to_string {
    my $self = shift;
    my $coerce = 'STRING';
    return unless my $type = $self->type;
    return $coercable->{$type}{$coerce}->($self);
}

*to_a = \&to_array;
*to_c = \&to_code;
*to_h = \&to_hash;
*to_n = \&to_number;
*to_s = \&to_string;

1;
