package Bubblegum::Object::Role::Output;

use Bubblegum::Role 'requires', 'with';

with 'Bubblegum::Object::Role::Defined';

requires 'print';
requires 'printf';
requires 'say';
requires 'sayf';
requires 'sprintf';
requires 'ssayf';

our $VERSION = '0.07'; # VERSION

1;
