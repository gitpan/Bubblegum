package Bubblegum::Role::Configuration;

use Bubblegum::Syntax;

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

use Module::Find 'usesub';
use parent 'autobox';

requires 'import';

our $VERSION = '0.11'; # VERSION

sub prerequisites {
    my ($class, $target) = @_;
    my $ignore = ($target =~ /^Bubblegum::Object/);

    # config
    mro::set_mro $target, 'c3';
    usesub Bubblegum::Object unless $ignore;

    # imports
    'strict'->import::into($target);
    'warnings'->import::into($target, 'FATAL', 'all');
    'autodie'->import::into($target, ':all');
    'feature'->import::into($target, ':5.10');
    'utf8::all'->import::into($target);
    'English'->import::into($target, '-no_match_vars');

    # autobox
    $target->SUPER::import(%{$Bubblegum::Syntax::EXTS});
}

1;
