package Bubblegum::Object::Role::Defined;

use 5.10.0;
use Bubblegum::Role 'with';

with 'Bubblegum::Object::Role::Item';

our $VERSION = '0.29'; # VERSION

sub defined {
    return 1
}

1;
