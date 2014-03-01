package Bubblegum::Exception;

use 5.10.0;

use strict;
use utf8::all;
use warnings;

use base 'Exception::Tiny';

our $VERSION = '0.14'; # VERSION

sub data {
    return shift->{data};
}

1;
