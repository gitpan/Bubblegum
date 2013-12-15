package Bubblegum::Role;

use Moo 'with';

with 'Bubblegum::Role::Configuration';

sub import {
    my $target = caller;
    my $class  = shift;
    my @export = @_;

    $class->prerequisites($target);
    Moo::Role->import::into($target, @export);
}

1;
