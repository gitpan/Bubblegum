# ABSTRACT: Prototype-based Programming for Bubblegum
package Bubblegum::Prototype;

use Bubblegum;
use Carp;
use Import::Into;

sub import {
    my $target = caller;
    my $class  = shift;

    'Bubblegum'->import::into($target);

    no strict 'refs';
    *{"${target}::extend"} = $class->can('build_clone');
    *{"${target}::object"} = $class->can('build_object');
}

sub build_attribute {
    my ($class, $key, $val) = @_;
    $class = ref($class) || $class;
    my @default = defined $val ? (default => $val) : ();
    $class->can('has')->($key => (is => 'rw', @default));
}

my $serial = 0;
sub build_class {
    my $class  = __PACKAGE__;
    my $common = "Bubblegum::Object::Prototype";
    my $base   = shift // $common;
    my $name   = sprintf '%s::__ANON__::%04d', $common, ++$serial;
    my $extend = $base->isa($common) || $base eq $common ?
        "extends '$base'" : "use base '$base'";
    eval join ';', ("package $name", "use Bubblegum::Class", $extend);
    croak $@ if $@;
    return $name;
}

sub build_clone {
    my $class  = shift;
    my $common = "Bubblegum::Object::Prototype";
    my $base   = ref($class) || $class;
    my $args   = ref($class) ? {%{$class}} : {};
    build_properties(my $name = build_class($base), @_);
    return $name->new($base->isa($common) ? ($args->merge({@_})->list) : @_);
}

sub build_method {
    my ($class, $key, $val) = @_;
    $class = ref($class) || $class;
    no strict 'refs';
    no warnings 'redefine';
    *{"${class}::$key"} = $val;
}

sub build_properties {
    my ($class, %properties) = @_;
    $class = ref($class) || $class;
    while (my ($key, $val) = each %properties) {
        build_method $class, $key, $val and next if $val and $val->isa_coderef;
        build_attribute $class, $key, ref $val ? sub { $val } : $val;
    }
}

sub build_object {
    build_properties(my $name = build_class, @_);
    return $name->new;
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Bubblegum::Prototype - Prototype-based Programming for Bubblegum

=head1 VERSION

version 0.38

=head1 SYNOPSIS

    use Bubblegum::Prototype;

    my $bear = object
        name     => 'bear',
        type     => 'black bear',
        attitude => 'indifferent',
        responds => sub { 'Roarrrr' },
        begets   => sub { shift->isa(ref shift) }
    ;

    my $papa = extend $bear,
        name     => 'papa bear',
        type     => 'great big papa bear',
        attitude => 'agitated',
        responds => sub { "Who's been eating my porridge?" },
    ;

    my $baby = extend $papa,
        name     => 'baby bear',
        type     => 'tiny little baby bear',
        responds => sub { "Who's eaten up all my porridge?" },
    ;

    my $mama = extend $bear,
        name     => 'mama bear',
        type     => 'middle-sized mama bear',
        attitude => 'confused',
        responds => sub { "Who's been eating my porridge?" },
    ;

    if ($papa && $mama && $baby && $baby->begets($papa)) {
        my $statement = 'The %s said, "%s"';

        $papa->name->titlecase->format($statement, $papa->responds)->say;
        $mama->name->titlecase->format($statement, $mama->responds)->say;
        $baby->name->titlecase->format($statement, $baby->responds)->say;

        # The Papa Bear said, "Who's been eating my porridge?"
        # The Mama Bear said, "Who's been eating my porridge?"
        # The Baby Bear said, "Who's eaten up all my porridge?"
    }

=head1 DESCRIPTION

Bubblegum::Prototype implements a thin prototype-like layer on top of the
L<Bubblegum> development framework. This module allows you to develop using a
prototype-based style while leveraging the L<Moo> and/or L<Moose> object
systems, and the Bubblegum framework. Bubblegum::Prototype allows you to create,
mutate, and extend classes with very little code. Prototype-based programming is
a style of object-oriented programming in which classes are not present, and
behavior reuse (known as inheritance in class-based languages) is performed via
a process of cloning existing objects that serve as prototypes. Due to
familiarity with class-based languages such as Java, many programmers assume
that object-oriented programming is synonymous with class-based programming.
However, class-based programming is just one kind of object-oriented programming
style, and other varieties exist such as role-oriented, aspect-oriented and
prototype-based programming. A prominent example of a prototype-based
programming language is ECMAScript (a.k.a. JavaScript or JScript). B<Note: This
is an early release available for testing and feedback and as such is subject to
change.>

=head2 OVERVIEW

    my $movie = object;

The object function, exported by Bubblegum::Prototype, creates an anonymous
class object (blessed hashref), derived from L<Bubblegum::Object::Prototype>.
The function can optionally take a list of key/value pairs. The keys with values
which are code references will be implemented as class methods, otherwise
will be implemented as class attributes.

    my $shrek = object
        name      => 'Shrek',
        filepath  => '/path/to/shrek',
        lastseen  => sub { (stat(shift->filepath))[8] },
        directors => ['Andrew Adamson', 'Vicky Jenson'],
        actors    => ['Mike Myers', 'Eddie Murphy', 'Cameron Diaz'],
    ;

As previously stated, with prototype-based programming, reuse is commonly
achieved by extending prototypes (i.e. cloning existing objects which also serve
as templates). The extend function, also exported by Bubblegum::Prototype,
creates an anonymous class object (blessed hashref), derived from the specified
class or object.

    my $shrek2 = extend $shrek,
        name     => 'Shrek2',
        filepath => '/path/to/shrek2',
    ;

    # additional credited director
    $shrek2->directors->push('Conrad Vernon');

The thing being extended does not have to be an existing prototype, you can
actually extend any class or blessed object you like (provided that the
underlying structure is a hashref). You don't even have to preload the module,
simply pass the class name to the extend function, along with any parameters you
would like the class to be instantiated with. Please note that what is returned
is not an instance of the class specified, instead, what will be returned is a
prototype derived from the class specified.

    my $imdb_search = extend 'IMDB::Film' => (
        crit => $shrek2->name,
    );

    $shrek2 = extend $shrek2 => (
        imdb_search => $imdb_search,
    );

Any objects created via prototype can be further extended using the mixin_class
and/or mixin_role methods, provided by L<Bubblegum::Object::Prototype>, which
uses the API of the underlying object system to extend the subject.

The mixin_class method upgrades the subject using multiple inheritance. Please
note that calling this method more than once will replace your superclasses, not
add to them.

    # replaces existing superclass for testing
    $film_search->mixin_class('mock_search');

The mixin_role method modifies the subject using role composition. Please note
that applying a role will not overwrite existing methods. If you desire to
overwrite existing methods, please extend the object, then apply the roles
desired.

    # add credentials and request methods dynamically
    $film_search->mixin_role('authorization');
    $film_search->mixin_role('director_search');

=head1 AUTHOR

Al Newkirk <anewkirk@ana.io>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Al Newkirk.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
