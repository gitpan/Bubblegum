package Bubblegum::Object::Role::Item;

use Bubblegum::Role 'requires';

requires 'defined';

our $VERSION = '0.07'; # VERSION

sub class {
    my $self = CORE::shift;
    my $map  = bbblgm::mappings();

    return $map->{type($self)};
}

sub of {
    my $self = CORE::shift;
    my $type = bbblgm::chkstr CORE::shift;
    my $map  = bbblgm::mappings();

    my $alias = {
        arrayref => 'array',
        coderef  => 'code',
        hashref  => 'hash',
        int      => 'integer',
        nil      => 'undef',
        null     => 'undef',
        num      => 'number',
        str      => 'string',
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
