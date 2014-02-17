package Bubblegum::Object::Role::Indexed;

use Bubblegum::Role 'requires', 'with';

with 'Bubblegum::Object::Role::Collection';

requires 'slice';

our $VERSION = '0.11'; # VERSION

1;
