package Bubblegum::Object::Role::Value;

use 5.10.0;
use namespace::autoclean;

use Bubblegum::Role 'with';
use Bubblegum::Constraints 'type_coderef';

with 'Bubblegum::Object::Role::Defined';

our $VERSION = '0.33'; # VERSION

sub do {
    my $self = CORE::shift;
    my $code = type_coderef CORE::shift;
    local $_ = $self;
    return $code->($self);
}

1;
