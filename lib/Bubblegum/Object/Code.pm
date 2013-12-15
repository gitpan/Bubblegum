package Bubblegum::Object::Code;

use Bubblegum 'with';

with 'Bubblegum::Object::Role::Defined';
with 'Bubblegum::Object::Role::Ref';

sub call {
    my $self = CORE::shift;
    my @args = @_;
    return $self->(@args);
}

sub curry {
    my $self = CORE::shift;
    my @args = @_;
    return sub { $self->(@args, @_) };
}

sub rcurry {
    my $self = CORE::shift;
    my @args = @_;
    return sub { $self->(@_, @args) };
}

sub compose {
    my $self = CORE::shift;
    my $next = bbbl'gm::chkcode CORE::shift;
    my @args = @_;
    return (sub { $next->($self->(@_)) })->compose(@args);
}

sub disjoin {
    my $self = CORE::shift;
    my $next = bbbl'gm::chkcode CORE::shift;
    return sub { $self->(@_) || $next->(@_) };
}

sub conjoin {
    my $self = CORE::shift;
    my $next = bbbl'gm::chkcode CORE::shift;
    return sub { $self->(@_) && $next->(@_) };
}

sub next {
    goto &call;
}

1;
