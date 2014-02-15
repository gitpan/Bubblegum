package Bubblegum::Object::Role::Value;

use Bubblegum::Role 'with';
use Bubblegum::Syntax -types;

with 'Bubblegum::Object::Role::Defined';

our $VERSION = '0.10'; # VERSION

sub do {
    my $self = CORE::shift;
    my $code = type_cref CORE::shift;

    local $_ = $self;
    return $code->($self);
}

1;
