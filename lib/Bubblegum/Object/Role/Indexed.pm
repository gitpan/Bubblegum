package Bubblegum::Object::Role::Indexed;

use Bubblegum::Role 'requires', 'with';

with 'Bubblegum::Object::Role::Collection';

requires 'slice';

our $VERSION = '0.05'; # VERSION

1;
