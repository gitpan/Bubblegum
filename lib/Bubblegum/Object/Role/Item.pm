package Bubblegum::Object::Role::Item;

use Bubblegum::Role 'requires';
use Bubblegum::Syntax -types;

our $VERSION = '0.12'; # VERSION

requires 'defined';

sub class {
    my $self = CORE::shift;
    my $map  = $Bubblegum::Syntax::EXTS;

    return $map->{type($self)};
}

sub of {
    my $self = CORE::shift;
    my $type = type_str CORE::shift;
    my $map  = $Bubblegum::Syntax::EXTS;

    my $alias = {
        aref  => 'array',
        cref  => 'code',
        href  => 'hash',
        int   => 'integer',
        nil   => 'undef',
        null  => 'undef',
        num   => 'number',
        str   => 'string',
        undef => 'undef',
    };

    if ($alias->{$type}) {
        $type = $alias->{$type};
    }

    my $kind = $map->{uc $type};

    return $kind && $self->autobox_class->isa($kind) ? 1 : 0;
}

sub type {
    my $self = CORE::shift;
    return autobox::universal::type $self;
}

sub typeof {
    goto &of;
}

1;
