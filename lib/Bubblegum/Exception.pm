# ABSTRACT: General Purpose Exception Class for Bubblegum
package Bubblegum::Exception;

use 5.10.0;

use strict;
use utf8::all;
use warnings;

use base 'Exception::Tiny';

our $VERSION = '0.15'; # VERSION

sub data {
    return shift->{data};
}


1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Bubblegum::Exception - General Purpose Exception Class for Bubblegum

=head1 VERSION

version 0.15

=head1 SYNOPSIS

    Bubblegum::Exception->throw('oh nooo');

=head1 DESCRIPTION

Bubblegum::Exception provides a general purpose exception object to be thrown
and caught and rethrow. This module is derives from L<Exception::Tiny> and
provides all the functionality found in that module. Additionally, this module
allows you to include arbitrary data which can be access by the block which
catches the exception.

    try {
        Bubblegum::Exception->throw(
            message => 'you broke something',
            data    => $something
        );
    } catch ($exception) {
        if ($exception->data->isa('Something')) {
            $exception->rethrow;
        }
    }

=head1 AUTHOR

Al Newkirk <anewkirk@ana.io>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Al Newkirk.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
