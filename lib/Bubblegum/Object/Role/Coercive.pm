package Bubblegum::Object::Role::Coercive;

use 5.10.0;
use namespace::autoclean;

use Bubblegum::Role 'requires';

our $VERSION = '0.32'; # VERSION

requires 'to_array';
requires 'to_code';
requires 'to_hash';
requires 'to_integer';
requires 'to_string';

sub to_undef {
    return undef;
}

1;
