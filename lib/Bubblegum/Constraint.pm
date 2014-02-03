package Bubblegum::Constraint;

use 5.10.0;
use utf8::all;
use strict;
use warnings;

use Type::Params ();
use Types::Standard ();

use Scalar::Util 'blessed';
use base 'Exporter::Tiny';

our @EXPORT_OK  = qw(
    asa_arrayref
    asa_coderef
    asa_hashref
    asa_number
    asa_ref
    asa_regexp
    asa_string
    isa_arrayref
    isa_classref
    isa_coderef
    isa_evenlist
    isa_hashref
    isa_regexp
);

our $VERSION = '0.08'; # VERSION

sub asa_arrayref {
    my $arrayref   = shift;
    my $constraint = Types::Standard::ArrayRef;
    Type::Params::compile($constraint)->($arrayref);
    return $arrayref;
}

sub asa_coderef {
    my $coderef    = shift;
    my $constraint = Types::Standard::CodeRef;
    Type::Params::compile($constraint)->($coderef);
    return $coderef;
}

sub asa_hashref {
    my $hashref    = shift;
    my $constraint = Types::Standard::HashRef;
    Type::Params::compile($constraint)->($hashref);
    return $hashref;
}

sub asa_number {
    my $number     = shift;
    my $constraint = Types::Standard::Num;
    Type::Params::compile($constraint)->($number);
    return $number;
}

sub asa_ref {
    my $reference  = shift;
    my $constraint = Types::Standard::Ref;
    Type::Params::compile($constraint)->($reference);
    return $reference;
}

sub asa_regexp {
    my $regexp     = shift;
    my $constraint = Types::Standard::RegexpRef;
    Type::Params::compile($constraint)->($regexp);
    return $regexp;
}

sub asa_string {
    my $string     = shift;
    my $constraint = Types::Standard::Str;
    Type::Params::compile($constraint)->($string);
    return $string;
}

sub isa_arrayref {
    return "ARRAY" eq ref(shift) ? 1 : 0;
}

sub isa_classref {
    return blessed(shift) ? 1 : 0;
}

sub isa_coderef {
    return "CODE" eq ref(shift) ? 1 : 0;
}

sub isa_evenlist {
    @_ % 2 ? 0 : 1
}

sub isa_hashref {
    return "HASH" eq ref(shift) ? 1 : 0;
}

sub isa_regexp {
    return "Regexp" eq ref(shift) ? 1 : 0;
}

1;
