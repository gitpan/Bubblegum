package Bubblegum::Wrapper::Yaml;

use Bubblegum::Class;
use YAML::Tiny ();

extends 'Bubblegum::Object::Instance';

our $VERSION = '0.07'; # VERSION

sub decode {
    my $self = shift;
    my $yaml = YAML::Tiny->new;
    return $yaml->read_string($self->data);
}

sub encode {
    my $self = shift;
    my $yaml = YAML::Tiny->new;

    $yaml->[0] = $self->data; # hack
    return $yaml->write_string($self->data);
}

1;
