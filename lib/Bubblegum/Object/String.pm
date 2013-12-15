package Bubblegum::Object::String;

use Bubblegum 'with';
use Scalar::Util ();

with 'Bubblegum::Object::Role::Defined';
with 'Bubblegum::Object::Role::Comparison';
with 'Bubblegum::Object::Role::Value';

sub eq {
    my $self  = CORE::shift;
    my $other = bbbl'gm::chkstr CORE::shift;

    return $self eq $other ? 1 : 0;
}

sub eqtv {
    my $self  = CORE::shift;
    my $other = CORE::shift;

    return 0 unless CORE::defined $other;
    return ($self->type eq $other->type && $self eq $other) ? 1 : 0;
}

sub gt {
    my $self  = CORE::shift;
    my $other = bbbl'gm::chkstr CORE::shift;

    return $self gt $other ? 1 : 0;
}

sub gte {
    my $self  = CORE::shift;
    my $other = bbbl'gm::chkstr CORE::shift;

    return $self ge $other ? 1 : 0;
}

sub lt {
    my $self  = CORE::shift;
    my $other = bbbl'gm::chkstr CORE::shift;

    return $self lt $other ? 1 : 0;
}

sub lte {
    my $self  = CORE::shift;
    my $other = bbbl'gm::chkstr CORE::shift;

    return $self le $other ? 1 : 0;
}

sub ne {
    my $self  = CORE::shift;
    my $other = bbbl'gm::chkstr CORE::shift;

    return $self ne $other ? 1 : 0;
}

sub camelcase {
    my $self = CORE::shift;
    return CORE::ucfirst(CORE::lc("$self"))
        =~ s/[^a-zA-Z0-9]+([a-z])/\U$1/gr =~ s/\W+//gr;
}

sub chomp {
    my $self = CORE::shift;
    return CORE::chomp $self;
}

sub chop {
    my $self = CORE::shift;
    return CORE::chop $self;
}

sub index {
    my ($self, $substr, $pos) = @_;
    bbbl'gm::chknum $substr;
    return CORE::index $self, $substr if scalar @_ == 2;

    bbbl'gm::chknum $pos;
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
    return [CORE::split '\n', $self];
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
    bbbl'gm::chknum $substr;
    return CORE::rindex $self, $substr if scalar @_ == 2;

    bbbl'gm::chknum $pos;
    return CORE::rindex $self, $substr, $pos;
}

sub snakecase {
    my $self = CORE::shift;
    return CORE::lc("$self")
        =~ s/[^a-zA-Z0-9]+([a-z])/\U$1/gr =~ s/\W+//gr;
}

sub split {
    my ($self, $regexp, $limit) = @_;
    bbbl'gm::chkre $regexp;
    return [CORE::split $regexp, $self] if scalar @_ == 2;

    bbbl'gm::chknum $limit;
    return [CORE::split $regexp, $self, $limit];
}

sub strip {
    my $self = CORE::shift;
    $self =~ s/\s{2,}/ /g;
    return $self;
}

sub titlecase {
    my $self = CORE::shift;
    return $self =~ s/\b(\w)/\U$1/gr;
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
    return [CORE::split ' ', $self];
}

1;
