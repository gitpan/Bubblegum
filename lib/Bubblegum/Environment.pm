package Bubblegum::Environment;

use Bubblegum;

use Data::Dumper ();
use File::HomeDir ();
use File::Find::Rule ();
use File::Which ();
use DateTime::Tiny ();
use Path::Tiny ();
use Time::Format ();
use Time::ParseDate ();

extends 'Bubblegum::Object::Instance';

has 'data' => (
    is   => 'ro',
    lazy => 1
);

sub _build_data {
    my $self = shift;
    # walk around and discover the environment
    return {};
}

sub cwd {
    my $self = shift;
    return Path::Tiny->cwd;
}

sub date {
    my $self  = shift;
    my $input = shift || 'now';
    my $epoch = $self->date_epoch($input, @_);
    my $date  = $self->date_format($epoch) or return;

    DateTime::Tiny->from_string($date);
}

sub date_epoch {
    my $self  = shift;
    my $input = shift || 'now';
    my $epoch = [Time::ParseDate::parsedate $input, @_];

    return $epoch->[0] or undef;
}

sub date_format {
    my $self   = shift;
    my $epoch  = shift or return;
    my $format = shift || 'yyyy-mm-ddThh:mm:ss';
    # my $format = shift || 'yyyy-mm{on}-dd hh:mm{in}:ss tz'; # not atm

    return Time::Format::time_format $format, $epoch;
}

sub dump {
    my $self = shift;
    my $data = shift // $self->data;

    return Data::Dumper->new([$data])
        ->Indent(1)->Sortkeys(1)->Terse(1)->Dump;
}

sub env {
    my $self = shift;
    my $key  = shift;
    my $env  = { map { lc $_ => $ENV{$_} } keys %ENV };
    return $key ? $env->{$key} : $env;
}

sub file {
    goto &path;
}

sub find {
    my $self = shift;
    my $spec = @_ == 1 ? '*.*' : pop;
    my $path ||= $self->path(@_);

    return [
        map { $self->path($_) }
            File::Find::Rule->file()->name($spec)->in($path)
    ];
}

sub home {
    my $self = shift;
    my $user = shift // $self->env('user');
    my $func = $user ? 'my_home' : 'users_home';
    return $self->path(File::HomeDir->can($func)->next($user));
}

sub lib {
    my $self  = shift;
    my $depth = shift // 0;
    my $start = $self->file($0)->parent;
    my $path  = $depth ? $start->parent($depth) : $start;
    return $path->child('lib')->stringify;
}

sub path {
    my $self = shift;
    my $path = Path::Tiny::path(@_);

    return $path;
}

sub quote {
    my $self   = shift;
    my $string = shift;
    return unless $string->typeof('str');

    $string =~ s/(["\\])/\\$1/g;
    return qq{"$string"};
}

sub script {
    my $self = shift;
    return $self->file($0);
}

sub unquote {
    my $self   = shift;
    my $string = shift;
    return unless $string->typeof('str');
    return $string unless $string =~ s/^"(.*)"$/$1/g;

    $string =~ s/\\\\/\\/g;
    $string =~ s/\\"/"/g;
    return $string;
}

sub user {
    my $self = shift;
    return $self->user_info->[0];
}

sub user_info {
    return [(getpwuid $>)];
}

sub which {
    my $self = shift;
    my $exec = shift;
    return $self->path(File::Which::which($exec));
}

sub AUTOLOAD {
    my $self  = shift;
    my $class = __PACKAGE__;
    my $name  = eval "\$${class}::AUTOLOAD" or die $@;
    my ($method) = $name =~ /::([^:]+)$/;

    # proxy method map
    my $methodmap = {
        # no yet
    };

    if ($method) {
        # almost
    }

    bbbl'gm::croak
        CORE::sprintf q(Can't locate object method "%s" via package "%s"),
            $method, ((ref $_[0] || $_[0]) || 'main');
}

{
    no warnings 'once';
    *DESTROY   = sub {};
    *TIESCALAR = \&new;
    *FETCH     = \&new;
    *STORE     = \&new;
}

1;
