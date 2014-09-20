# ABSTRACT: Common Methods for Operating on Undefined Values
package Bubblegum::Object::Undef;

use 5.10.0;
use namespace::autoclean;

use Bubblegum::Class 'with';

with 'Bubblegum::Object::Role::Item';
with 'Bubblegum::Object::Role::Coercive';

our @ISA = (); # non-object

our $VERSION = '0.35'; # VERSION

sub defined {
    return 0
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Bubblegum::Object::Undef - Common Methods for Operating on Undefined Values

=head1 VERSION

version 0.35

=head1 SYNOPSIS

    use Bubblegum;

    my $nothing = undef;
    say $nothing->defined ? 'Yes' : 'No'; # No

=head1 DESCRIPTION

Undefined methods work on variables whose data meets the criteria for being
undefined. It is not necessary to use this module as it is loaded automatically
by the L<Bubblegum> class.

=head1 METHODS

=head2 defined

    my $nothing = undef;
    $nothing->defined ? 'Yes' : 'No'; # No

The defined method always returns false.

=head1 SEE ALSO

L<Bubblegum::Object::Array>, L<Bubblegum::Object::Code>,
L<Bubblegum::Object::Hash>, L<Bubblegum::Object::Instance>,
L<Bubblegum::Object::Integer>, L<Bubblegum::Object::Number>,
L<Bubblegum::Object::Scalar>, L<Bubblegum::Object::String>,
L<Bubblegum::Object::Undef>, L<Bubblegum::Object::Universal>,

=head1 AUTHOR

Al Newkirk <anewkirk@ana.io>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Al Newkirk.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
