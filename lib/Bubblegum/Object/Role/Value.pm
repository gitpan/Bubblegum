package Bubblegum::Object::Role::Value;

use Bubblegum::Role 'with';

with 'Bubblegum::Object::Role::Defined';

our $VERSION = '0.07'; # VERSION

sub do {
    my $self = CORE::shift;
    my $code = bbblgm::chkcode CORE::shift;

    local $_ = $self;
    return $code->($self);
}

1;
