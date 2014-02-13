package Bubblegum::Object::Role::Indexed;

use Bubblegum::Role 'requires', 'with';

with 'Bubblegum::Object::Role::Collection';

requires 'slice';

our $VERSION = '0.09'; # VERSION

1;
