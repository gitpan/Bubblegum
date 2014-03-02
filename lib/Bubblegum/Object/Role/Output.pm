package Bubblegum::Object::Role::Output;

use Bubblegum::Role 'requires', 'with';

with 'Bubblegum::Object::Role::Defined';

our $VERSION = '0.16'; # VERSION

requires 'print';
requires 'printf';
requires 'say';
requires 'sayf';

1;
