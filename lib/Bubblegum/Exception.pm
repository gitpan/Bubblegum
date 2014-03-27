# ABSTRACT: General Purpose Exception Class for Bubblegum
package Bubblegum::Exception;

use 5.10.0;

use Data::Dumper ();
use Scalar::Util ();

use Moo 'has';
use overload bool => sub {1}, q{""} => 'as_string', fallback => 1;

our $VERSION = '0.23'; # VERSION

has file => (
    is       => 'ro',
    required => 1
);

has line => (
    is       => 'ro',
    required => 1
);

has message => (
    is       => 'ro',
    required => 1
);

has package => (
    is       => 'ro',
    required => 1
);

has subroutine => (
    is       => 'ro',
    required => 1
);

sub throw {
    my $class = shift;
    my %args  = @_ == 1 ? (message => $_[0]) : @_;

    $args{message} = "An unknown error occurred in class ($class)"
        unless defined $args{message} && $args{message} ne '';

    $args{subroutine} = (caller(1))[3];
    ($args{package}, $args{file}, $args{line}) = caller(0);

    die $class->new(%args);
}

sub rethrow {
    die shift;
}

sub as_string {
    my $self = shift;
    sprintf '%s at %s line %s.', $self->message, $self->file, $self->line;
}

sub dump {
    local $Data::Dumper::Terse = 1;
    Data::Dumper::Dumper(shift);
}

sub caught {
    my($class, $e) = @_;
    return if ref $class;
    return unless Scalar::Util::blessed($e) && UNIVERSAL::isa($e, $class);
    return $e;
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Bubblegum::Exception - General Purpose Exception Class for Bubblegum

=head1 VERSION

version 0.23

=head1 SYNOPSIS

    Bubblegum::Exception->throw('oh nooo!!!');

=head1 DESCRIPTION

Bubblegum::Exception provides a general purpose exception object to be thrown
and caught and rethrow.

    try {
        Bubblegum::Exception->throw(
            message => 'you broke something'
        );
    }
    catch ($exception) {
        if (Bubblegum::Exception->caught($exception)) {
            # you belong to me
            $exception->rethrow;
        }
    };

=encoding utf8

=head1 AUTHOR

Al Newkirk <anewkirk@ana.io>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Al Newkirk.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
