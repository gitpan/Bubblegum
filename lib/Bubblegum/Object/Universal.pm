# ABSTRACT: Common Methods for Operating on Defined Values
package Bubblegum::Object::Universal;

use 5.10.0;
use Bubblegum::Exception;
use Class::Forward;

use Bubblegum::Class 'with';
use Bubblegum::Constraints 'type_classname', 'type_object', 'type_string';
use Class::Load 'load_class';
use Scalar::Util 'blessed';

our @ISA = (); # non-object

our $VERSION = '0.27'; # VERSION

sub instance {
    my $self  = CORE::shift;
    my $class = load_class 'Bubblegum::Object::Instance';
    return type_object $class->new(data => $self);
}

sub utils {
    my $self = CORE::shift;
    my $type = CORE::lc autobox::universal::type $self;
    return wrapper($self, "${type}/utils");
}

sub wrapper {
    my $self    = CORE::shift;
    my $name    = type_string CORE::shift;
    my $space   = 'Bubblegum::Wrapper';
    my $wrapper = Class::Forward->new(namespace => $space)->forward($name);
    my $plugin  = type_classname(load_class($wrapper));
    return $plugin->new(data => $self) if $plugin;
}

sub AUTOLOAD {
    my $self   = shift;
    my $caller = caller;
    my ($class, $method) = split /::(\w+)$/, our $AUTOLOAD;

    if ($self->can($method)) {
        unshift @_, $self;
        goto $self->can($method);
    }

    # try plugin
    if (my $plugin = eval {wrapper($self, $method)}) {
        return $plugin->new(@_, data => $self) if $plugin;
    }

    Bubblegum::Exception->throw(
        verbose => 1,
        message => $method->format(
            q(Can't locate object method "%s" via package "%s"),
                ((blessed($self) ? ref $self : $caller) || 'main')
        )
    );
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Bubblegum::Object::Universal - Common Methods for Operating on Defined Values

=head1 VERSION

version 0.27

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

=encoding utf8

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
