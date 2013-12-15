package Bubblegum::Wrapper::Digest;

use Bubblegum;
use Digest::MD5 ();
use Digest::SHA ();

extends 'Bubblegum::Object::Instance';

sub BUILD {
    my $self = shift;

    $self->data->typeof('str') or bbbl'gm::croak
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
