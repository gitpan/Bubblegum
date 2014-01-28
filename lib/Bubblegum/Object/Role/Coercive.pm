package Bubblegum::Object::Role::Coercive;

use Bubblegum::Role 'requires';

requires 'to_array';
requires 'to_code';
requires 'to_hash';
requires 'to_integer';
requires 'to_string';

our $VERSION = '0.07'; # VERSION

sub to_undef {
    return undef;
}

1;
