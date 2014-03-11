package Bubblegum::Object::Role::Indexed;

use Bubblegum::Role 'requires', 'with';

with 'Bubblegum::Object::Role::Collection';

our $VERSION = '0.19'; # VERSION

requires 'slice';

1;
