package Bubblegum::Object::Role::Indexed;

use Bubblegum::Role 'requires', 'with';

with 'Bubblegum::Object::Role::Collection';

our $VERSION = '0.13'; # VERSION

requires 'slice';

1;
