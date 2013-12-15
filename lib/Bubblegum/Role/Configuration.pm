package Bubblegum::Role::Configuration;

use Bubblegum::Constraint;

use 5.10.0;
use utf8::all;
use strict;
use warnings;
use Moo::Role;
use Class::Forward;
use Import::Into;
use Try::Tiny;

use mro     ();
use feature ();

use Carp 'croak';
use Class::Load 'load_class';
use Module::Find 'usesub';
use parent 'autobox';

our $Wrapper = $ENV{'BUBBLEGUM_WRAPPER'} // 'Bubblegum::Wrapper';
my  $loaded  = 0;

requires 'import';

sub bbbl'gm::chk {
    goto &Bubblegum::check;
}

sub bbbl'gm::chkarray {
    unshift @_, 'arrayref';
    goto &Bubblegum::check;
}

sub bbbl'gm::chkcode {
    unshift @_, 'coderef';
    goto &Bubblegum::check;
}

sub bbbl'gm::chkhash {
    unshift @_, 'hashref';
    goto &Bubblegum::check;
}

sub bbbl'gm::chknum {
    unshift @_, 'number';
    goto &Bubblegum::check;
}

sub bbbl'gm::chkref {
    unshift @_, 'ref';
    goto &Bubblegum::check;
}

sub bbbl'gm::chkre {
    unshift @_, 'regexp';
    goto &Bubblegum::check;
}

sub bbbl'gm::chkstr {
    unshift @_, 'string';
    goto &Bubblegum::check;
}

sub bbbl'gm::croak {
    goto &croak;
}

sub bbbl'gm::forward {
    goto &forward;
}

sub bbbl'gm::instance {
    goto &Bubblegum::instance;
}

sub bbbl'gm::load {
    goto &Bubblegum::load;
}

sub bbbl'gm::mappings {
    goto &Bubblegum::mappings;
}

sub check {
    my $type    = shift;
    my $value   = shift;
    my $context = [caller(1)];

    my $check = Bubblegum::Constraint->can("asa_$type")
        or croak "The constraint name ($type) is invalid";

    try {
        $check->($value);
    }
    catch {
        my $exception = $_[0];
        $exception->{context}{package} = $context->[0];
        $exception->{context}{file}    = $context->[1];
        $exception->{context}{line}    = $context->[2];
        die $exception;
    };
}

sub forward {
    load(Class::Forward->new(namespace => $Wrapper)->forward(shift));
}

sub instance {
    load('Bubblegum::Object::Instance')->new(data => shift);
}

sub load {
    load_class @_;
}

sub mappings {{
    ARRAY     => 'Bubblegum::Object::Array',
    CODE      => 'Bubblegum::Object::Code',
    FLOAT     => 'Bubblegum::Object::Float',
    HASH      => 'Bubblegum::Object::Hash',
    INTEGER   => 'Bubblegum::Object::Integer',
    NUMBER    => 'Bubblegum::Object::Number',
    SCALAR    => 'Bubblegum::Object::Scalar',
    STRING    => 'Bubblegum::Object::String',
    UNDEF     => 'Bubblegum::Object::Undef',
    UNIVERSAL => 'Bubblegum::Object::Universal',
}}

sub prerequisites {
    my ($class, $target) = @_;
    my $ignore = ($target =~ /^Bubblegum::Object/);

    mro::set_mro $target, 'c3';
    usesub Bubblegum::Object unless $ignore;

    'utf8::all'->import::into($target);
    'strict'->import::into($target);
    'warnings'->import::into($target, qw(FATAL all));
    'autodie'->import::into($target, qw(:all));
    'feature'->import::into($target, qw(:5.10));

    # autobox
    $target->SUPER::import(%{mappings()});

    # $*
    $target ne 'Bubblegum::Environment' and eval q(
        package bbbl'gm::env;
        no warnings 'all';
        require Bubblegum::Environment unless $ignore;
        require Tie::Scalar;
        $* = Bubblegum::Environment->new;
        tie $*, 'Bubblegum::Environment';
    );
}

1;
