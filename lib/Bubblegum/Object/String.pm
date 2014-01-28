# ABSTRACT: Common Methods for Operating on Strings
package Bubblegum::Object::String;

use Bubblegum::Class 'with';
use Scalar::Util ();

with 'Bubblegum::Object::Role::Defined';
with 'Bubblegum::Object::Role::Comparison';
with 'Bubblegum::Object::Role::Value';

our $VERSION = '0.07'; # VERSION



sub eq {
    my $self  = CORE::shift;
    my $other = bbblgm::chkstr CORE::shift;

    return $self eq $other ? 1 : 0;
}


sub eqtv {
    my $self  = CORE::shift;
    my $other = CORE::shift;

    return 0 unless CORE::defined $other;
    return ($self->type eq $other->type && $self eq $other) ? 1 : 0;
}


sub format {
    my $self   = CORE::shift;
    my $format = bbblgm::chkstr CORE::shift;

    return CORE::sprintf $format, $self;
}


sub gt {
    my $self  = CORE::shift;
    my $other = bbblgm::chkstr CORE::shift;

    return $self gt $other ? 1 : 0;
}


sub gte {
    my $self  = CORE::shift;
    my $other = bbblgm::chkstr CORE::shift;

    return $self ge $other ? 1 : 0;
}


sub lt {
    my $self  = CORE::shift;
    my $other = bbblgm::chkstr CORE::shift;

    return $self lt $other ? 1 : 0;
}


sub lte {
    my $self  = CORE::shift;
    my $other = bbblgm::chkstr CORE::shift;

    return $self le $other ? 1 : 0;
}


sub ne {
    my $self  = CORE::shift;
    my $other = bbblgm::chkstr CORE::shift;

    return $self ne $other ? 1 : 0;
}


sub camelcase {
    my $self = CORE::shift;
    $self = CORE::ucfirst(CORE::lc("$self"));
    $self =~ s/[^a-zA-Z0-9]+([a-z])/\U$1/g;
    $self =~ s/[^a-zA-Z0-9]+//g;
    return $self;
}


sub chomp {
    my $self = CORE::shift;
    CORE::chomp $self;
    return $self;
}


sub chop {
    my $self = CORE::shift;
    CORE::chop $self;
    return $self;
}


sub hex {
    my $self = CORE::shift;
    return CORE::hex $self;
}


sub index {
    my ($self, $substr, $pos) = @_;
    bbblgm::chkstr $substr;
    return CORE::index $self, $substr if scalar @_ == 2;

    bbblgm::chknum $pos;
    return CORE::index $self, $substr, $pos
}


sub lc {
    my $self = CORE::shift;
    return CORE::lc $self;
}


sub lcfirst {
    my $self = CORE::shift;
    return CORE::lcfirst $self;
}


sub length {
    my $self = CORE::shift;
    return CORE::length $self;
}


sub lines {
    my $self = CORE::shift;
    return [CORE::split /\n+/, $self];
}


sub lowercase {
    goto &lc
}


sub reverse {
    my $self = CORE::shift;
    return CORE::reverse $self;
}


sub rindex {
    my ($self, $substr, $pos) = @_;
    bbblgm::chkstr $substr;
    return CORE::rindex $self, $substr if scalar @_ == 2;

    bbblgm::chknum $pos;
    return CORE::rindex $self, $substr, $pos;
}


sub snakecase {
    my $self = CORE::shift;
    $self = CORE::lc("$self");
    $self =~ s/[^a-zA-Z0-9]+([a-z])/\U$1/g;
    $self =~ s/[^a-zA-Z0-9]+//g;
    return $self;
}


sub split {
    my ($self, $regexp, $limit) = @_;
    bbblgm::chkre $regexp;
    return [CORE::split $regexp, $self] if scalar @_ == 2;

    bbblgm::chknum $limit;
    return [CORE::split $regexp, $self, $limit];
}


sub strip {
    my $self = CORE::shift;
    $self =~ s/\s{2,}/ /g;
    return $self;
}


sub titlecase {
    my $self = CORE::shift;
    $self =~ s/\b(\w)/\U$1/g;
    return $self;
}


sub to_array {
    my $self = CORE::shift;
    return ["$self"];
}


sub to_code {
    my $self = CORE::shift;
    return sub {"$self"};
}


sub to_hash {
    my $self = CORE::shift;
    goto {"$self"=>"$self"};
}


sub to_integer {
    my $self = CORE::shift;
    return Scalar::Util::looks_like_number($self) ? 0 + $self : 0;
}


sub to_string {
    my $self = CORE::shift;
    return $self;
}


sub trim {
    my $self = CORE::shift;
    $self =~ s/^\s+|\s+$//g;
    return $self;
}


sub uc {
    my $self = CORE::shift;
    return CORE::uc $self;
}


sub ucfirst {
    my $self = CORE::shift;
    return CORE::ucfirst $self;
}


sub uppercase {
    goto &uc;
}


sub words {
    my $self = CORE::shift;
    return [CORE::split /\s+/, $self];
}

1;

__END__

=pod

=head1 NAME

Bubblegum::Object::String - Common Methods for Operating on Strings

=head1 VERSION

version 0.07

=head1 SYNOPSIS

    use Bubblegum;

    my $greeting = 'hello world';
    say $greeting->titlecase->format('%s!!!'); # Hello World!!!

=head1 DESCRIPTION

String methods work on data that meets the criteria for being a string. A string
holds and manipulates an arbitrary sequence of bytes, typically representing
characters. Users of strings should be aware of the methods that modify the
string itself as opposed to returning a new string. Unless stated, it may be
safe to assume that the following methods copy, modify and return new strings
based on their subjects.

=head1 METHODS

=head2 eq

    my $string = 'User';
    $string->eq('user'); # 0; false
    $string->eq('User'); # 1; true

The eq method returns true if the argument matches the subject, otherwise
returns false. Equality is case-sensative.

=head2 eqtv

    my $string = '123';
    $string->eqtv('123'); # 1; true
    $string->eqtv(123); # 0; false

The eqtv method returns true if the argument matches the subject's type and
value, otherwise returns false. This function is akin to the strict-comparison
operator in other languages.

=head2 format

    my $string = 'bobama';
    $string->format('/home/%s/etc'); # /home/bobama/etc

The format method returns a string formatted using the argument as a template
and the subject as a variable using the same conventions as the 'sprintf'
function.

=head2 gt

    my $string = 'abc';
    $string->gt('ABC'); # 1; true
    $string->gt('abc'); # 0; false

The gt method performs binary "greater than" and returns true if the subject is
stringwise greater than the argument. Note, this operation expects the argument
to be a string.

=head2 gte

    my $string = 'abc';
    $string->gte('abc'); # 1; true
    $string->gte('ABC'); # 1; true
    $string->gte('abcd'); # 0; false

The gte method performs binary "greater than or equal to" and returns true if
the subject is stringwise greater than or equal to the argument. Note, this
operation expects the argument to be a string.

=head2 lt

    my $string = 'ABC';
    $string->lt('abc'); # 1; true
    $string->lt('ABC'); # 0; false

The lt method performs binary "less than" and returns true if the subject is
stringwise less than the argument. Note, this operation expects the argument to
be a string.

=head2 lte

    my $string = 'ABC';
    $string->lte('abc'); # 1; true
    $string->lte('ABC'); # 1; true
    $string->lte('AB'); # 0; false

The lte method performs binary "less than or equal to" and returns true if
the subject is stringwise less than or equal to the argument. Note, this
operation expects the argument to be a string.

=head2 ne

    my $string = 'User';
    $string->ne('user'); # 1; true
    $string->ne('User'); # 0; false

The ne method returns true if the argument does not match the subject, otherwise
returns false. Equality is case-sensative.

=head2 camelcase

    my $string = 'hello world';
    $string->camelcase; # HelloWorld

The camelcase method modifies the subject such that it will no longer have any
non-alphanumeric characters and each word (group of alphanumeric characters
separated by 1 or more non-alphanumeric characters) is capitalized. Note, this
method modifies the subject.

=head2 chomp

    my $string = "name, age, dob, email\n";
    $string->chomp; # name, age, dob, email

The chomp method is a safer version of the chop method, it's used to remove the
newline (or the current value of $/) from the end of the subject. Note, this
method modifies and returns the subject.

=head2 chop

    my $string = "this is just a test.";
    $string->chop; # this is just a test

The chop method removes the last character of a string and returns the character
chopped. It is much more efficient than "s/.$//s" because it neither scans nor
copies the string. Note, this method modifies and returns the subject.

=head2 hex

    my $string = '0xaf';
    string->hex; # 175

The hex method returns the value resulting from interpreting the subject as a
hex string.

=head2 index

    my $string = 'unexplainable';
    $string->index('explain'); # 2
    $string->index('explain', 0); # 2
    $string->index('explain', 1); # 2
    $string->index('explain', 2); # 2
    $string->index('explain', 3); # -1
    $string->index('explained'); # -1

The index method searches for the argument within the subject and returns the
position of the first occurrence of the argument. This method optionally takes a
second argument which would be the position within the subject to start
searching from (also known as the base). By default, starts searching from the
beginning of the string.

=head2 lc

    my $string = 'EXCITING';
    $string->lc; # exciting

The lc method returns a lowercased version of the subject.

=head2 lcfirst

    my $string = 'EXCITING';
    $string->lcfirst; # eXCITING

The lcfirst method returns a the subject with the first character lowercased.

=head2 length

    my $string = 'longggggg';
    $string->length; # 9

The length method returns the number of characters within the subject.

=head2 lines

    my $string = "who am i?\nwhere am i?\nhow did I get here";
    $string->lines; # ['who am i','where am i','how did i get here']

The lines method breaks the subject into pieces, split on 1 or more newline characters, and returns an array reference consisting of the pieces.

=head2 lowercase

    my $string = 'EXCITING';
    $string->lowercase; # exciting

The lowercase method is an alias to the lc method.

=head2 reverse

    my $string = 'dlrow ,olleH';
    $string->reverse; # Hello, world

The reverse method returns a string where the characters in the subject are in
the opposite order.

=head2 rindex

    my $string = 'explain the unexplainable';
    $string->rindex('explain'); # 14
    $string->rindex('explain', 0); # 14
    $string->rindex('explain', 1); # 14
    $string->rindex('explain', 2); # 14
    $string->rindex('explain', 2); # 14
    $string->rindex('explain', 20); # 14
    $string->rindex('explain', 14); # 14
    $string->rindex('explain', 13); # 0
    $string->rindex('explain', 0); # 0
    $string->rindex('explained'); # -1

The rindex method searches for the argument within the subject and returns the
position of the last occurrence of the argument. This method optionally takes a
second argument which would be the position within the subject to start
searching from (beginning at or before the position). By default, starts
searching from the end of the string.

=head2 snakecase

    my $string = 'hello world';
    $string->snakecase; # helloWorld

The snakecase method modifies the subject such that it will no longer have any
non-alphanumeric characters and each word (group of alphanumeric characters
separated by 1 or more non-alphanumeric characters) is capitalized. The only
difference between this method and the camelcase method is that this method
ensures that the first character will always be lowercased. Note, this method
modifies the subject.

=head2 split

    my $string = 'name, age, dob, email';
    $self->split(qr/\,\s*/); # ['name', 'age', 'dob', 'email']
    $self->split(qr/\,\s*/, 2); # ['name', 'age']

The split method splits the subject into a list of strings, separating each
chunk by the argument (regexp object), and returns that list as an array
reference. This method optionally takes a second argument which would be the
limit (number of matches to capture). Note, this operation expects the 1st
argument to be a Regexp object.

=head2 strip

    my $string = 'one  , two  , three';
    $string->strip; # one, two, three

The strip method returns the subject replacing occurences of 2 or more
whitespaces with a single whitespace. Note, this method modifies the subject.

=head2 titlecase

    my $string = 'mr. wellington III';
    $string->titlecase; # Mr. Wellington III

The titlecase method returns the subject capitalizing the first character of
each word (group of alphanumeric characters separated by 1 or more whitespaces).
Note, this method modifies the subject.

=head2 to_array

    my $string = 'uniform';
    $string->to_array; # ['uniform']

The to_array method is used for coercion and simply returns an array reference
where the first element contains the subject.

=head2 to_code

    my $string = 'uniform';
    $string->to_code; # sub { 'uniform' }

The to_code method is used for coercion and simply returns a code reference
which always returns the subject when called.

=head2 to_hash

    my $string = 'uniform';
    $string->to_hash; # { 'uniform' => 'uniform' }

The to_hash method is used for coercion and simply returns a hash reference
with a single key and value, having the key and value both contain the subject.

=head2 to_integer

    my $string = 'uniform';
    $string->to_integer; # 0

    $string = '123';
    $string->to_integer; # 123

The to_integer method is used for coercion and simply returns the numeric
version of the subject based on whether the subject "looks like a number", if
not, returns 0.

=head2 to_string

    my $string = 'uniform';
    $string->to_string; # uniform

The to_string method is used for coercion and simply returns the subject.

=head2 trim

    my $string = ' system is   ready   ';
    $string->trim; # system is   ready

The trim method removes 1 or more consecutive leading and/or trailing spaces
from the subject. Note, this method modifies the subject.

=head2 uc

    my $string = 'exciting';
    $string->uc; # EXCITING

The uc method returns an uppercased version of the subject.

=head2 ucfirst

    my $string = 'exciting';
    $string->ucfirst; # Exciting

The ucfirst method returns a the subject with the first character uppercased.

=head2 uppercase

    my $string = 'exciting';
    $string->uppercase; # EXCITING

The uppercase method is an alias to the uc method.

=head2 words

    my $string = "is this a bug we're experiencing";
    $self->words; # ["is","this","a","bug","we're","experiencing"]

The words method splits the subject into a list of strings, separating each
group of characters by 1 or more consecutive spaces, and returns that list as an
array reference.

=head1 AUTHOR

Al Newkirk <anewkirk@ana.io>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Al Newkirk.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
