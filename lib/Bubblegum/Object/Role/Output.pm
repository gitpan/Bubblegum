package Bubblegum::Object::Role::Output;

use 5.10.0;
use Bubblegum::Role 'requires', 'with';

with 'Bubblegum::Object::Role::Defined';

our $VERSION = '0.30'; # VERSION

requires 'print';
requires 'say';

1;
