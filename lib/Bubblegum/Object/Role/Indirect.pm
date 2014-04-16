package Bubblegum::Object::Role::Indirect;

use 5.10.0;
use Bubblegum::Exception;
use Bubblegum::Role;

our $VERSION = '0.27'; # VERSION

sub indirect {
    my $object  = shift;
    my $method  = shift;
    my $codestr = pop;
    my $routine = $object->autobox_class->can($method);

    my $coderef = eval
        sprintf 'sub {%s}', join ';',
            map { /^\s*\$\w+$/ ? "my$_=shift" : "$_" }
            map { /^\s*\@\w+$/ ? "my$_=\@_"   : "$_" }
            map { /^\s*\%\w+$/ ? "my$_=\@_"   : "$_" }
        split /;/, $codestr;

    Bubblegum::Exception->throw(message => "$@", verbose => 1) if $@;
    return ($routine->($object, (@_ ? (@_, $coderef) : $coderef)));
}

1;
