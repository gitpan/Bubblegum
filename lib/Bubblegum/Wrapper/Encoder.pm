package Bubblegum::Wrapper::Encoder;

use Bubblegum::Class;
use Encode 'find_encoding';

extends 'Bubblegum::Object::Instance';

our $VERSION = '0.08'; # VERSION

sub BUILD {
    my $self = shift;

    $self->data->typeof('str') or bbblgm::croak
        CORE::sprintf q(Wrapper package "%s" requires string data), ref $self;
}

sub decode {
    my $self = shift;
    my $type = shift // 'utf-8';
    my $decoder = find_encoding $type;

    return undef unless $decoder;
    return $decoder->decode($self->data);
}

sub encode {
    my $self = shift;
    my $type = shift // 'utf-8';
    my $encoder = find_encoding $type;

    return undef unless $encoder;
    return $encoder->encode($self->data);
}

1;
