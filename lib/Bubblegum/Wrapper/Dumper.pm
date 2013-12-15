package Bubblegum::Wrapper::Dumper;

use Bubblegum;
use Data::Dumper ();

extends 'Bubblegum::Object::Instance';

sub decode {
    my $self = shift;
    return eval $self->data;
}

sub encode {
    my $self = shift;
    return Data::Dumper->new([$self->data])
        ->Indent(0)->Sortkeys(1)->Terse(1)->Dump;
}

1;
