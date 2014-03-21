# ABSTRACT: Type and Constraints Library for Bubblegum
package Bubblegum::Constraints;

use 5.10.0;

use strict;
use utf8::all;
use warnings;

use Bubblegum::Exception;
use Try::Tiny;

use Type::Params ();
use Types::Standard ();

use base 'Exporter::Tiny';

our $VERSION = '0.20'; # VERSION


our $EXTS = {
    ARRAY     => 'Bubblegum::Object::Array',
    CODE      => 'Bubblegum::Object::Code',
    FLOAT     => 'Bubblegum::Object::Float',
    HASH      => 'Bubblegum::Object::Hash',
    INTEGER   => 'Bubblegum::Object::Integer',
    NUMBER    => 'Bubblegum::Object::Number',
    SCALAR    => 'Bubblegum::Object::Scalar',
    STRING    => 'Bubblegum::Object::String',
    UNDEF     => 'Bubblegum::Object::Undef',
    UNIVERSAL => 'Bubblegum::Object::Universal',
};

my $TYPES = {
    ArrayRef   => [qw(aref arrayref)],
    Bool       => [qw(bool boolean)],
    ClassName  => [qw(class classname)],
    CodeRef    => [qw(cref coderef)],
    Defined    => [qw(def defined)],
    FileHandle => [qw(fh filehandle)],
    GlobRef    => [qw(glob globref)],
    HashRef    => [qw(href hashref)],
    Int        => [qw(int integer)],
    Num        => [qw(num number)],
    Object     => [qw(obj object)],
    Ref        => [qw(ref reference)],
    RegexpRef  => [qw(rref regexpref)],
    ScalarRef  => [qw(sref scalarref)],
    Str        => [qw(str string)],
    Undef      => [qw(nil null undef undefined)],
    Value      => [qw(val value)],
};

our @EXPORT_OK;
our %EXPORT_TAGS = (
    attr => sub {
        no strict 'refs';
        no warnings 'redefine';
        my $args   = pop;
        my $target = $args->{into};
        my $maker  = $target->can('has') or return;
        *{"${target}::has"} = sub {
            my $type    = shift if isa_coderef($_[0]);
            my $names   = isa_aref($_[0]) ? $_[0] : [$_[0]];
            my $builder = $_[1] if isa_coderef($_[1]);
            if ((@_ == 1 xor @_ == 2) && $names) {
                for my $name (@{$names}) {
                    my %props = (is => 'ro');
                    if ($type) {
                        $props{isa} = $type;
                    }
                    if ($builder) {
                        $props{builder} = "_build_${name}";
                        *{"${target}::$props{builder}"} = $builder;
                    }
                    $maker->($name => (%props));
                }
            }
            else {
                $maker->(@_);
            }
            return;
        };
        return;
    },
    minimal => sub {
        no strict 'refs';
        my $class = shift;
        my $name  = 'EXPORT_TAGS';
        my $tags  = \%{"${class}::${name}"};
        $tags->{attr}->(@_);
        return @{$tags->{constraints}},
            @{$tags->{isas}}, @{$tags->{nots}};
    },
    typing => sub {
        no strict 'refs';
        my $class = shift;
        my $name  = 'EXPORT_TAGS';
        my $tags  = \%{"${class}::${name}"};
        $tags->{attr}->(@_);
        return @{$tags->{types}}, @{$tags->{typesof}},
            @{$tags->{isas}}, @{$tags->{nots}};
    },
);
{
    no strict 'refs';
    my $package  = __PACKAGE__;
    my $compiler = Type::Params->can('compile');
    while (my($class, $names) = each %{$TYPES}) {
        my $validator  = Types::Standard->can($class);
        my $validation = $compiler->($validator->());
        for my $name (@{$names}) {
            # generate isas
            {
                my $name = "isa_$name";
                push @EXPORT_OK, $name;
                push @{$EXPORT_TAGS{isas}}, $name;
                *{"${package}::${name}"} = sub (;*) {
                    my $data = shift;
                    return eval { $validation->($data) } || 0;
                };
            }
            # generate nots
            {
                my $name = "not_$name";
                push @EXPORT_OK, $name;
                push @{$EXPORT_TAGS{nots}}, $name;
                *{"${package}::${name}"} = sub (;*) {
                    my $data = shift;
                    return ! eval { $validation->($data) } || 0;
                };
            }
            # generate types
            {
                my $name = "type_$name";
                push @EXPORT_OK, $name;
                push @{$EXPORT_TAGS{types}}, $name;
                *{"${package}::${name}"} = sub (;*) {
                    my $data = shift;
                    my $context = [caller(0)];
                    try {
                        $validation->($data);
                        return $data;
                    } catch {
                        my $error = $_[0];
                        $error->{context}{package} = $context->[0];
                        $error->{context}{file}    = $context->[1];
                        $error->{context}{line}    = $context->[2];
                        die $error;
                    };
                };
            }
            # generate typeofs
            {
                my $name = "typeof_$name";
                push @EXPORT_OK, $name;
                push @{$EXPORT_TAGS{typesof}}, $name;
                *{"${package}::${name}"} = sub () {
                    return $validation;
                };
            }
            # generate for constraints
            {
                push @EXPORT_OK, "_$name";
                push @{$EXPORT_TAGS{constraints}}, "_$name";
                *{"${package}::_${name}"} = sub (;*) {
                    !@_ # two-in-one function
                    ? goto $package->can("typeof_$name")
                    : goto $package->can("type_$name");
                };
            }
        }
    }
}










1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Bubblegum::Constraints - Type and Constraints Library for Bubblegum

=head1 VERSION

version 0.20

=head1 SYNOPSIS

    package Server;

    use Bubblegum::Class;
    use Bubblegum::Constraints -typing;

    has typeof_hashref, config => sub {
        # load config data
    };

=head1 DESCRIPTION

Bubblegum::Constraints is the standard type-checking library for L<Bubblegum>
applications with a focus on minimalism and data integrity.

=head1 EXPORTS

By default, no functions are exported when using this package, all functionality
desired will need to be explicitly requested, and because many functions belong
to a particular group of functions there are export tags which can be used to
export sets of functions by group name. Any function can also be exported
individually. The following are a list of functions and groups currently
available:

=head2 -attr

The attr export group currently exports a single functions which overrides the
C<has> accessor maker in the calling class and implements a more flexible
interface specification. If the C<has> function does not exist in the caller's
namespace then override will be aborted, otherwise, the C<has> function will now
support the following:

    has 'attr1';

is the equivalent of:

    has 'attr1' => (
        is => 'ro',
    );

and if type validators are exported via C<-typesof>, or C<-typing>:

    use Bubblegum::Constraints -typesof;

    has typeof_object, 'attr2';

is the equivalent of:

    has 'attr2' => (
        is  => 'ro',
        isa => typeof_object,
    );

and/or including a default value, for example:

    use Bubblegum::Constraints -typesof;

    has 'attr1' => sub {
        # define lazy builder attr1
    };

    has typeof_object, 'attr2' => sub {
        # define lazy builder attr2
    };

is the equivalent of:

    has 'attr1' => (
        is      => 'ro',
        builder => '_build_attr1',
    );

    sub _build_attr1 {
        # ...
    }

    has 'attr2' => (
        is      => 'ro',
        isa     => typeof_object,
        builder => '_build_attr2',
    );

    sub _build_attr2 {
        # ...
    }

=head2 -constraints

The constraints export group exports all functions which have the C<_> prefix
and provides functionality similar to importing the L</-types> and L</-typesof>
export groups except that the functions it emits are abbreviated multi-purpose
versions of the functions emitted by the -types and -typesof export groups.
These functions take a single argument and perform fatal type checking, or, if
invoked with no arguments returns a code reference to the fatal type checking
routine. The following is a list of functions exported by this group:

=over 4

=item *

_aref

=item *

_arrayref

=item *

_bool

=item *

_boolean

=item *

_class

=item *

_classname

=item *

_cref

=item *

_coderef

=item *

_def

=item *

_defined

=item *

_fh

=item *

_filehandle

=item *

_glob

=item *

_globref

=item *

_href

=item *

_hashref

=item *

_int

=item *

_integer

=item *

_num

=item *

_number

=item *

_obj

=item *

_object

=item *

_ref

=item *

_reference

=item *

_rref

=item *

_regexpref

=item *

_sref

=item *

_scalarref

=item *

_str

=item *

_string

=item *

_nil

=item *

_null

=item *

_undef

=item *

_undefined

=back

=head2 -isas

The isas export group exports all functions which have the C<isa_> prefix. These
functions take a single argument and perform non-fatal type checking and return
true or false. The following is a list of functions exported by this group:

=over 4

=item *

isa_aref

=item *

isa_arrayref

=item *

isa_bool

=item *

isa_boolean

=item *

isa_class

=item *

isa_classname

=item *

isa_cref

=item *

isa_coderef

=item *

isa_def

=item *

isa_defined

=item *

isa_fh

=item *

isa_filehandle

=item *

isa_glob

=item *

isa_globref

=item *

isa_href

=item *

isa_hashref

=item *

isa_int

=item *

isa_integer

=item *

isa_num

=item *

isa_number

=item *

isa_obj

=item *

isa_object

=item *

isa_ref

=item *

isa_reference

=item *

isa_rref

=item *

isa_regexpref

=item *

isa_sref

=item *

isa_scalarref

=item *

isa_str

=item *

isa_string

=item *

isa_nil

=item *

isa_null

=item *

isa_undef

=item *

isa_undefined

=back

=head2 -minimal

The minimal export group exports all functions from the L</-constraints>,
L</-isas>, and L</-nots> export groups as well as the functionality provided by
the L</-attr> tag. It is a means to export the simplest type-related
functionality.

=head2 -nots

The nots export group exports all functions which have the C<not_> prefix. These
functions take a single argument and perform non-fatal negated type checking and
return true or false. The following is a list of functions exported by this
group:

=over 4

=item *

not_aref

=item *

not_arrayref

=item *

not_bool

=item *

not_boolean

=item *

not_class

=item *

not_classname

=item *

not_cref

=item *

not_coderef

=item *

not_def

=item *

not_defined

=item *

not_fh

=item *

not_filehandle

=item *

not_glob

=item *

not_globref

=item *

not_href

=item *

not_hashref

=item *

not_int

=item *

not_integer

=item *

not_num

=item *

not_number

=item *

not_obj

=item *

not_object

=item *

not_ref

=item *

not_reference

=item *

not_rref

=item *

not_regexpref

=item *

not_sref

=item *

not_scalarref

=item *

not_str

=item *

not_string

=item *

not_nil

=item *

not_null

=item *

not_undef

=item *

not_undefined

=back

=head2 -types

The types export group exports all functions which have the C<type_> prefix.
These functions take a single argument/expression and perform fatal type
checking operation returning the argument/expression if successful. The follow
is a list of functions exported by this group:

=over 4

=item *

type_aref

=item *

type_arrayref

=item *

type_bool

=item *

type_boolean

=item *

type_class

=item *

type_classname

=item *

type_cref

=item *

type_coderef

=item *

type_def

=item *

type_defined

=item *

type_fh

=item *

type_filehandle

=item *

type_glob

=item *

type_globref

=item *

type_href

=item *

type_hashref

=item *

type_int

=item *

type_integer

=item *

type_num

=item *

type_number

=item *

type_obj

=item *

type_object

=item *

type_ref

=item *

type_reference

=item *

type_rref

=item *

type_regexpref

=item *

type_sref

=item *

type_scalarref

=item *

type_str

=item *

type_string

=item *

type_nil

=item *

type_null

=item *

type_undef

=item *

type_undefined

=back

=head2 -typesof

The typesof export group exports all functions which have the C<typeof_> prefix.
These functions take no argument and return a type-validation code-routine to be
used with your object-system of choice. The following is a list of functions
exported by this group:

=over 4

=item *

typeof_aref

=item *

typeof_arrayref

=item *

typeof_bool

=item *

typeof_boolean

=item *

typeof_class

=item *

typeof_classname

=item *

typeof_cref

=item *

typeof_coderef

=item *

typeof_def

=item *

typeof_defined

=item *

typeof_fh

=item *

typeof_filehandle

=item *

typeof_glob

=item *

typeof_globref

=item *

typeof_href

=item *

typeof_hashref

=item *

typeof_int

=item *

typeof_integer

=item *

typeof_num

=item *

typeof_number

=item *

typeof_obj

=item *

typeof_object

=item *

typeof_ref

=item *

typeof_reference

=item *

typeof_rref

=item *

typeof_regexpref

=item *

typeof_sref

=item *

typeof_scalarref

=item *

typeof_str

=item *

typeof_string

=item *

typeof_nil

=item *

typeof_null

=item *

typeof_undef

=item *

typeof_undefined

=back

=head2 -typing

The typing export group exports all functions from the L</-types>, L</-typesof>,
L</-isas>, and L</-nots> export groups as well as the functionality provided by
the L</-attr> tag. It is a means to export all type-related functions minus the
multi-purpose functions provided by the L</-constraints> export group.

=head1 AUTHOR

Al Newkirk <anewkirk@ana.io>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Al Newkirk.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
