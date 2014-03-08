package Bubblegum::Object::Role::Coercive;

use Bubblegum::Role 'requires';

our $VERSION = '0.17'; # VERSION

requires 'to_array';
requires 'to_code';
requires 'to_hash';
requires 'to_integer';
requires 'to_string';

sub to_undef {
    return undef;
}

1;
