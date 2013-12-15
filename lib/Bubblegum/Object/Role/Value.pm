package Bubblegum::Object::Role::Value;

use Bubblegum::Role 'with';

with 'Bubblegum::Object::Role::Defined';

sub do {
    my $self = CORE::shift;
    my $code = bbbl'gm::chkcode CORE::shift;

    local $_ = $self;
    return $code->($self);
}

1;
