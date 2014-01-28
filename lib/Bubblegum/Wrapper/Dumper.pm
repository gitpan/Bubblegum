package Bubblegum::Wrapper::Dumper;

use Bubblegum::Class;
use Data::Dumper ();

extends 'Bubblegum::Object::Instance';

our $VERSION = '0.07'; # VERSION

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
