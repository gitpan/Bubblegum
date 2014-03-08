# ABSTRACT: Common Methods for Operating on Scalars
package Bubblegum::Object::Scalar;

use Scalar::Util ();

use Bubblegum::Class 'with';
use Bubblegum::Syntax -types;

with 'Bubblegum::Object::Role::Value';

our $VERSION = '0.17'; # VERSION



sub and {
    my ($self, $other) =  @_;
    return $self && $other;
}


sub not {
    my ($self) =  @_;
    return !$self;
}


sub or {
    my ($self, $other) =  @_;
    return $self || $other;
}


sub repeat {
    my $self   = CORE::shift;
    my $number = type_number CORE::shift;
    return $self x $number;
}


sub xor {
    my ($self, $other) =  @_;
    return ($self xor $other) ? 1 : 0;
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Bubblegum::Object::Scalar - Common Methods for Operating on Scalars

=head1 VERSION

version 0.17

=head1 SYNOPSIS

    use Bubblegum;

    my $variable = 12345;
    say $variable->or(56789); # 12345

=head1 DESCRIPTION

Scalar methods work on data that meets the criteria for being a defined. It is
not necessary to use this module as it is loaded automatically by the
L<Bubblegum> class.

=head1 METHODS

=head2 and

    my $variable = 12345;
    $variable->and(56789); # 56789

    $variable = 0;
    $variable->and(56789); # 0

The and method performs a short-circuit logical AND operation using the subject
as the lvalue and the argument as the rvalue and returns the last truthy value
or false.

=head2 not

    my $variable = 0;
    $variable->not; # 1

    $variable = 1;
    $variable->not; # ''

The not method performs a logical negation of the subject. It's the equivalent
of using bang (!) and return true (1) or false (empty string).

=head2 or

    my $variable = 12345;
    $variable->or(56789); # 12345

    $variable = 00000;
    $variable->or(56789); # 56789

The or method performs a short-circuit logical OR operation using the subject
as the lvalue and the argument as the rvalue and returns the first truthy value.

=head2 repeat

    my $variable = 12345;
    $variable->repeat(2); # 1234512345

    $variable = 'yes';
    $variable->repeat(2); # yesyes

The repeat method returns a string consisting of the subject repeated the number
of times specified by the argument.

=head2 xor

    my $variable = 1;
    $variable->xor(1); # 0
    $variable->xor(0); # 1

The xor method performs an exclusive OR operation using the subject as the
lvalue and the argument as the rvalue and returns true if either but not both
is true.

=head1 AUTHOR

Al Newkirk <anewkirk@ana.io>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Al Newkirk.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
