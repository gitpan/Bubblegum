# ABSTRACT: Common Methods for Operating on Defined Values
package Bubblegum::Object::Universal;

use Bubblegum::Class 'with';
use Bubblegum::Syntax -types, 'load', 'raise';

use Class::Forward;

our $VERSION = '0.11'; # VERSION



sub instance {
    my $self  = CORE::shift;
    my $class = load 'Bubblegum::Object::Instance';
    return type_obj $class->new(data => $self);
}


sub wrapper {
    my $self    = CORE::shift;
    my $name    = type_str CORE::shift;
    my $space   = 'Bubblegum::Wrapper';
    my $wrapper = Class::Forward->new(namespace => $space)->forward($name);
    my $plugin  = type_class(load($wrapper));
    return $plugin->new(data => $self) if $plugin;
}

sub AUTOLOAD {
    my $self  = shift;
    my $class = __PACKAGE__;
    my $name  = eval "\$${class}::AUTOLOAD" or die $@;
    my ($method) = $name =~ /::([^:]+)$/;

    if ($method) {
        my $plugin = eval { wrapper($self, $method) };
        return $plugin->new(@_, data => $self) if $plugin;
    }

    raise CORE::sprintf q(Can't locate object method "%s" via package "%s"),
        $method, ((ref $_[0] || $_[0]) || 'main');
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Bubblegum::Object::Universal - Common Methods for Operating on Defined Values

=head1 VERSION

version 0.11

=head1 SYNOPSIS

    use Bubblegum;

    my $thing = 0;
    $thing->instance; # bless({'data' => 0}, 'Bubblegum::Object::Instance')

=head1 DESCRIPTION

Universal methods work on variables whose data meets the criteria for being
defined. It is not necessary to use this module as it is loaded automatically by
the L<Bubblegum> class.

=head1 METHODS

=head2 instance

    my $thing = 0;
    $thing->instance; # bless({'data' => 0}, 'Bubblegum::Object::Instance')

    my $data = $thing->instance->data; # 0

The instance method blesses the subject into a generic container class,
Bubblegum::Object::Instance, and returns an instance. Please see
L<Bubblegum::Object::Instance> for more information.

=head2 wrapper

    my $thing = [1,0];
    $thing->wrapper('json'); # same as ...
    $thing->json; # bless({'data' => [1,0]}, 'Bubblegum::Wrapper::Json')

    my $json = $thing->json->encode; # [1,0]

The wrapper method blesses the subject into a Bubblegum wrapper, a container
class, which exists as an extension to the core data type methods, and returns
an instance. Please see any one of the core Bubblegum wrappers, e.g.,
L<Bubblegum::Wrapper::Digest>, L<Bubblegum::Wrapper::Dumper>,
L<Bubblegum::Wrapper::Encoder>, L<Bubblegum::Wrapper::Json> or
L<Bubblegum::Wrapper::Yaml>.

=head1 AUTHOR

Al Newkirk <anewkirk@ana.io>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Al Newkirk.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
