package Bubblegum::Role::Configuration;

use 5.10.0;
use namespace::autoclean;

use strict;
use utf8::all;
use warnings;

use Import::Into;
use Moo::Role;

use Bubblegum::Namespace ();
use feature ();
use mro ();

use Module::Find 'usesub';

use parent 'autobox';

our $VERSION = '0.31'; # VERSION

requires 'import';

sub prerequisites {
    my ($class, $target) = @_;
    my $ignore = ($target =~ /^Bubblegum::Object/);

    # config
    mro::set_mro $target, 'c3';
    usesub Bubblegum::Object unless $ignore;

    # imports
    'strict'    ->import::into($target);
    'warnings'  ->import::into($target);
    'utf8::all' ->import::into($target);
    'autodie'   ->import::into($target, ':all');
    'feature'   ->import::into($target, ':5.10');
    'English'   ->import::into($target, '-no_match_vars');

    # autoboxing
    no warnings 'once';
    $target->autobox::import(
        map { $_ => $$Bubblegum::Namespace::ExtendedTypes{$_} }
            keys %$Bubblegum::Namespace::DefaultTypes
    );
}

1;
