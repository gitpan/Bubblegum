package Bubblegum::Object::Role::Output;

use 5.10.0;
use Bubblegum::Role 'requires', 'with';

with 'Bubblegum::Object::Role::Defined';

our $VERSION = '0.28'; # VERSION

requires 'print';
requires 'printf';
requires 'say';
requires 'sayf';

1;
