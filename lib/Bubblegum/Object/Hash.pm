# ABSTRACT: Common Methods for Operating on Hash References
package Bubblegum::Object::Hash;

use Bubblegum::Class 'with';

with 'Bubblegum::Object::Role::Defined';
with 'Bubblegum::Object::Role::Keyed';
with 'Bubblegum::Object::Role::Ref';

our $VERSION = '0.07'; # VERSION



sub aslice {
    goto &array_slice;
}


sub array_slice {
    my $self = CORE::shift;
    my @keys = map { bbblgm::chkstr $_ } @_;
    return [@{$self}{@keys}];
}


sub defined {
    my $self = CORE::shift;
    my $key  = bbblgm::chkstr CORE::shift;
    return CORE::defined $self->{$key};
}


sub delete {
    my $self = CORE::shift;
    my $key  = bbblgm::chkstr CORE::shift;
    return CORE::delete $self->{$key};
}


sub each {
    my $self = CORE::shift;
    my $code = bbblgm::chkcode CORE::shift;

    for my $key (CORE::keys %$self) {
      $code->($key, $self->{$key});
    }

    return $self;
}


sub each_key {
    my $self = CORE::shift;
    my $code = bbblgm::chkcode CORE::shift;

    $code->($_) for CORE::keys %$self;
    return $self;
}


sub each_n_values {
    my $self   = CORE::shift;
    my $number = $_[0] ? bbblgm::chknum CORE::shift : 2;
    my $code   = bbblgm::chkcode CORE::shift;

    my @values = CORE::values %$self;
    $code->(CORE::splice @values, 0, $number) while @values;
    return $self;
}


sub each_value {
    my $self = CORE::shift;
    my $code = bbblgm::chkcode CORE::shift;

    $code->($_) for CORE::values %$self;
    return $self;
}


sub empty {
    my $self = CORE::shift;
    CORE::delete @$self{CORE::keys%$self};
    return $self;
}


sub exists {
    my $self = CORE::shift;
    my $key  = bbblgm::chkstr CORE::shift;
    return CORE::exists $self->{$key};
}


sub filter_exclude {
    my $self = CORE::shift;
    my @keys = map { bbblgm::chkstr $_ } @_;
    my %i    = map { $_ => bbblgm::chkstr $_ } @keys;

    return {CORE::map { CORE::exists $self->{$_} ? ($_ => $self->{$_}) : () }
        CORE::grep { not CORE::exists $i{$_} } CORE::keys %$self};
}


sub filter_include {
    my $self = CORE::shift;
    my @keys = map { bbblgm::chkstr $_ } @_;

    return {CORE::map { CORE::exists $self->{$_} ? ($_ => $self->{$_}) : () }
        @keys};
}


sub get {
    my $self = CORE::shift;
    my $key  = bbblgm::chkstr CORE::shift;
    return $self->{$key};
}


sub hash_slice {
    my $self = CORE::shift;
    my @keys = map { bbblgm::chkstr $_ } @_;
    return {CORE::map { $_ => $self->{$_} } @keys};
}


sub hslice {
    goto &hash_slice;
}


sub invert {
    my $self = CORE::shift;
    my $temp = {};

    for (CORE::keys %$self) {
        CORE::defined $self->{$_} ?
            $temp->{CORE::delete $self->{$_}} = $_ :
            CORE::delete $self->{$_};
    }

    for (CORE::keys %$temp) {
        $self->{$_} = CORE::delete $temp->{$_};
    }

    return $self;
}


sub iterator {
    my $self = CORE::shift;
    my @keys = map { bbblgm::chkstr $_ } @_;

    my $i = 0;
    return sub {
        return undef if $i > $#keys;
        return $self->{$keys[$i++]};
    }
}


sub keys {
    my $self = CORE::shift;
    return [CORE::keys %$self];
}


sub lookup {
    my $self = CORE::shift;
    my $key  = bbblgm::chkstr CORE::shift;
    my @keys = CORE::split /\./, $key;
    my $node = $self;
    for my $key (@keys) {
        if ('HASH' eq CORE::ref $node) {
            return undef unless CORE::exists $node->{$key};
            $node = $node->{$key};
        }
        else {
            return undef;
        }
    }
    return $node;
}


sub pairs {
    goto &pairs_array;
}


sub pairs_array {
    my $self = CORE::shift;
    return [CORE::map { [ $_, $self->{$_} ] } CORE::keys %$self];
}


sub list {
    my $self = CORE::shift;
    return %$self;
}


sub merge {
    my $self = CORE::shift;
    my $hash = bbblgm::chkhash CORE::shift;
    return {%$self, %$hash};
}


sub reset {
    my $self = CORE::shift;
    @$self{CORE::keys%$self}=();
    return $self;
}


sub reverse {
    my $self = CORE::shift;
    my $temp = {};

    for (CORE::keys %$self) {
        $temp->{$_} = $self->{$_} if defined $self->{$_};
    }

    return {CORE::reverse %$temp};
}


sub set {
    my $self = CORE::shift;
    my $key  = bbblgm::chkstr CORE::shift;
    return $self->{$key} = CORE::shift;
}


sub values {
    my $self = CORE::shift;
    return [CORE::values %$self];
}

1;

__END__

=pod

=head1 NAME

Bubblegum::Object::Hash - Common Methods for Operating on Hash References

=head1 VERSION

version 0.07

=head1 SYNOPSIS

    use Bubblegum;

    my $hash = {1..3,{4,{5,6,7,{8,9,10,11}}}};
    say $hash->lookup('3.4.7'); # {8=>9,10=>11}

=head1 DESCRIPTION

Hash methods work on hash references. Users of these methods should be aware
of the methods that modify the array reference itself as opposed to returning a
new array reference. Unless stated, it may be safe to assume that the following
methods copy, modify and return new hash references based on their subjects.

=head1 METHODS

=head2 aslice

    my $hash = {1..8};
    $hash->aslice(1,3); # [2,4]

The aslice method is an alias to the array_slice method.

=head2 array_slice

    my $hash = {1..8};
    $hash->array_slice(1,3); # [2,4]

The array_slice method returns an array reference containing the values in the
subject corresponding to the keys specified in the arguments in the order
specified.

=head2 defined

    my $hash = {1..8,9,undef};
    $hash->defined(1); # 1; true
    $hash->defined(0); # 0; false
    $hash->defined(9); # 0; false

The defined method returns true if the value matching the key specified in the
argument if defined, otherwise returns false.

=head2 delete

    my $hash = {1..8};
    $hash->delete(1); # 2

The delete method returns the value matching the key specified in the
argument and returns the value.

=head2 each

    my $hash = {1..8};
    $hash->each(sub{
        my $key   = shift; # 1
        my $value = shift; # 2
    });

The each method iterates over each element in the subject, executing the code
reference supplied in the argument, passing the routine the key and value at
the current position in the loop.

=head2 each_key

    my $hash = {1..8};
    $hash->each_key(sub{
        my $key = shift; # 1
    });

The each_key method iterates over each element in the subject, executing the
code reference supplied in the argument, passing the routine the key at the
current position in the loop.

=head2 each_n_values

    my $hash = {1..8};
    $hash->each_n_values(4, sub {
        my $value_1 = shift; # 2
        my $value_2 = shift; # 4
        my $value_3 = shift; # 6
        my $value_4 = shift; # 8
        ...
    });

The each_n_values method iterates over each element in the subject, executing
the code reference supplied in the argument, passing the routine the next n
values until all values have been seen.

=head2 each_value

    my $hash = {1..8};
    $hash->each_value(sub {
        my $value = shift; # 2
    });

The each_value method iterates over each element in the subject, executing the
code reference supplied in the argument, passing the routine the value at the
current position in the loop.

=head2 empty

    my $hash = {1..8};
    $hash->empty; # {}

The empty method drops all elements from the subject. Note, this method modifies
the subject.

=head2 exists

    my $hash = {1..8,9,undef};
    $hash->exists(1); # 1; true
    $hash->exists(0); # 0; false

The exists method returns true if the value matching the key specified in the
argument exists, otherwise returns false.

=head2 filter_exclude

    my $hash = {1..8};
    $hash->filter_exclude(1,3); # {5=>6,7=>8}

The filter_exclude method returns a hash reference consisting of all key/value
pairs in the subject except for the pairs whose keys are specified in the
arguments.

=head2 filter_include

    my $hash = {1..8};
    $hash->filter_include(1,3); # {1=>2,3=>4}

The filter_include method returns a hash reference consisting of only key/value
pairs whose keys are specified in the arguments.

=head2 get

    my $hash = {1..8};
    $hash->get(5); # 6

The get method returns the value of the element in the subject whose key
corresponds to the key specified in the argument.

=head2 hash_slice

    my $hash = {1..8};
    $hash->hash_slice(1,3); # {1=>2,3=>4}

The hash_slice method returns a hash reference containing the key/value pairs
in the subject corresponding to the keys specified in the arguments.

=head2 hslice

    my $hash = {1..8};
    $hash->hslice(1,3); # {1=>2,3=>4}

The hslice method is an alias to the array_slice method.

=head2 invert

    my $hash = {1..8,9,undef,10,''};
    $hash->invert; # {''=>10,2=>1,4=>3,6=>5,8=>7}

The invert method returns the subject after inverting the keys and values
respectively. Note, keys with undefined values will be dropped, also, this
method modifies the subject.

=head2 iterator

    my $hash = {1..8};
    my $iterator = $hash->iterator;
    while (my $value = $iterator->next) {
        say $value; # 2
    }

The iterator method returns a code reference which can be used to iterate over
the subject. Each time the iterator is executed it will return the values of the
next element in the subject until all elements have been seen, at which point
the iterator will return an undefined value.

=head2 keys

    my $hash = {1..8};
    $hash->keys; # [1,3,5,7]

The keys method returns an array reference consisting of all the keys in the
subject.

=head2 lookup

    my $hash = {1..3,{4,{5,6,7,{8,9,10,11}}}};
    $hash->lookup('3.4.7'); # {8=>9,10=>11}
    $hash->lookup('3.4'); # {5=>6,7=>{8=>9,10=>11}}
    $hash->lookup(1); # 2

The lookup method returns the value of the element in the subject whose key
corresponds to the key specified in the argument. The key can be a string which
references (using dot-notation) nested keys within the subject. This method will
return undefined if the value is undef or the location expressed in the argument
can not be resolved.

=head2 pairs

    my $hash = {1..8};
    $hash->pairs; # [[1,2],[3,4],[5,6],[7,8]]

The pairs method is an alias to the pairs_array method.

=head2 pairs_array

    my $hash = {1..8};
    $hash->pairs_array; # [[1,2],[3,4],[5,6],[7,8]]

The pairs_array method returns an array reference consisting of array references
where each sub array reference has two elements corresponding to the key and
value of each element in the subject.

=head2 list

    my $hash = {1..8};
    $hash->list; # (1,2,3,4,5,6,7,8)

The list method returns the elements in the subject as a list.

=head2 merge

    my $hash = {1..8};
    $hash->merge({7,7,9,9}); # {1=>2,3=>4,5=>6,7=>7,9=>9}

The list method returns a hash reference where the elements in the subject and
the elements in the argument are joined (i.e. a shallow-merge).

=head2 reset

    my $hash = {1..8};
    $hash->reset; # {1=>undef,3=>undef,5=>undef,7=>undef}

The reset method returns nullifies the value of each element in the subject.

=head2 reverse

    my $hash = {1..8,9,undef};
    $hash->reverse; # {8=>7,6=>5,4=>3,2=>1}

The reverse method returns a hash reference consisting of the subject's keys and
values inverted. Note, keys with undefined values will be dropped.

=head2 set

    my $hash = {1..8};
    $hash->set(1,10); # 10
    $hash->set(1,12); # 12
    $hash->set(1,0); # 0

The set method returns the value of the element in the subject corresponding to
the key specified by the argument after updating it to the value of the second
argument.

=head2 values

    my $hash = {1..8};
    $hash->values; # [2,4,6,8]

The values method returns an array reference consisting of the values of the
elements in the subject.

=head1 AUTHOR

Al Newkirk <anewkirk@ana.io>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Al Newkirk.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
