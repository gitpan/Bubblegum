# ABSTRACT: Singleton Pattern for Bubblegum via Moo
package Bubblegum::Singleton;

use 5.10.0;
use Moo 'with';

with 'Bubblegum::Role::Configuration';

our $VERSION = '0.15'; # VERSION

sub import {
    my $target = caller;
    my $class  = shift;
    my @export = @_;

    $class->prerequisites($target);
    Moo->import::into($target, @export);

    my $inst;
    my $orig = $class->can('new');
    no strict 'refs';
    *{"${target}::new"} = sub {
        $inst //= $orig->(@_)
    };

    if (!$class->can('renew')) {
        *{"${target}::renew"} = sub {
            $inst = $orig->(@_)
        };
    }
}


1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Bubblegum::Singleton - Singleton Pattern for Bubblegum via Moo

=head1 VERSION

version 0.15

=head1 SYNOPSIS

    package Configuration;

    use Bubblegum::Singleton;

    has 'options' => (
        is      => 'rw',
        default => sub {{
            auto_restart => 1
        }}
    );

And elsewhere:

    my $config = Configuration->new;
    $config->options->{auto_restart} = 0;

    $config = Configuration->new;
    say $config->options->{auto_restart}; # 0

    $config = $config->renew;
    say $config->options->{auto_restart}; # 1

=head1 DESCRIPTION

Bubblegum::Singleton provides a simple singleton object for your convenience by
way of L<Moo> and activates all of the options enabled by the L<Bubblegum>
module. Using this module allows you to define classes as if you were using Moo
directly.

    use Bubblegum::Singleton;

is equivalent to

    use 5.10.0;
    use strict;
    use autobox;
    use autodie ':all';
    use feature ':5.10';
    use warnings FATAL => 'all';
    use English -no_match_vars;
    use utf8::all;
    use mro 'c3';
    use Moo;

=head1 AUTHOR

Al Newkirk <anewkirk@ana.io>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Al Newkirk.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
