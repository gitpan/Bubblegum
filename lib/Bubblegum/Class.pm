package Bubblegum::Class;

use Moo 'with';

with 'Bubblegum::Role::Configuration';

our $VERSION = '0.07'; # VERSION

sub import {
    my $target = caller;
    my $class  = shift;
    my @export = @_;

    $class->prerequisites($target);
    Moo->import::into($target, @export);
}

1;
