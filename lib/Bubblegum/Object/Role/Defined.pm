package Bubblegum::Object::Role::Defined;

use Bubblegum::Role 'with';

with 'Bubblegum::Object::Role::Item';

our $VERSION = '0.19'; # VERSION

sub defined {
    return 1
}

1;
