package Bubblegum::Wrapper::Digest;

use Bubblegum::Class;
use Digest::MD5 ();
use Digest::SHA ();

extends 'Bubblegum::Object::Instance';

our $VERSION = '0.07'; # VERSION

sub BUILD {
    my $self = shift;

    $self->data->typeof('str') or bbblgm::croak
        CORE::sprintf q(Wrapper package "%s" requires string data), ref $self;
}

sub encode {
    my $self = shift;
    my $type = shift // 'md5_hex';

    my $encoder;
    my $md5 = [qw(md5 md5_hex)];
    my $sha = [qw(sha1_base64 sha1 sha1_hex)];
    my $hmc = [qw(hmac_sha1 hmac_sha1_hex)];

    $encoder = 'Digest::MD5' if $md5->one eq $type;
    $encoder = 'Digest::SHA' if $sha->one eq $type;
    $encoder = 'Digest::SHA' if $hmc->one eq $type;

    return undef unless $encoder;
    return $encoder->can($type)->($self->data);
}

1;
