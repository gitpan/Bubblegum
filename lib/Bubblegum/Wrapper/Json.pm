# ABSTRACT: Bubblegum Wrapper around JSON Serialization
package Bubblegum::Wrapper::Json;

use Bubblegum::Class;

use JSON::Tiny ();

extends 'Bubblegum::Object::Instance';

our $VERSION = '0.15'; # VERSION



sub decode {
    my $self = shift;
    my $json = JSON::Tiny->new;
    return $json->decode($self->data);
}


sub encode {
    my $self = shift;
    my $json = JSON::Tiny->new;
    return $json->encode($self->data);
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Bubblegum::Wrapper::Json - Bubblegum Wrapper around JSON Serialization

=head1 VERSION

version 0.15

=head1 SYNOPSIS

    use Bubblegum;

    my $data = {1..3,{4,{5,6,7,{8,9,10,11}}}};

    my $string  = $data->json->encode;
    my $hashref = $string->json->decode;

=head1 DESCRIPTION

L<Bubblegum::Wrapper::Json> is a Bubblegum wrapper which provides the ability to
endcode/decode JSON data structures. It is not necessary to use this module as
it is loaded automatically by the L<Bubblegum> class.

=head1 METHODS

=head2 decode

The decode method deserializes the stringified JSON structure using the
L<JSON::Tiny> module.

=head2 encode

The encode method serializes the Perl data structure using the L<JSON::Tiny>
module.

=head1 AUTHOR

Al Newkirk <anewkirk@ana.io>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Al Newkirk.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
