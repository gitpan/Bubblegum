package Bubblegum::Object::Role::Defined;

use Bubblegum::Role 'with';

with 'Bubblegum::Object::Role::Item';

sub defined {
    return 1
}

1;
