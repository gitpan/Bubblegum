package Bubblegum::Object::Undef;

use Bubblegum 'with';

with 'Bubblegum::Object::Role::Item';

sub defined {
    return 0
}

1;
