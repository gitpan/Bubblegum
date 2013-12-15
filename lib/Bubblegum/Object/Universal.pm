package Bubblegum::Object::Universal;

use Bubblegum;

sub instance {
    my $self = CORE::shift;
    return bbbl'gm::instance $self;
}

sub wrapper {
    my $self   = CORE::shift;
    my $name   = bbbl'gm::chkstr CORE::shift;
    my $plugin = bbbl'gm::forward $name;
    return $plugin->new(data => $self) if $plugin;
}

sub AUTOLOAD {
    my $self  = shift;
    my $class = __PACKAGE__;
    my $name  = eval "\$${class}::AUTOLOAD" or die $@;
    my ($method) = $name =~ /::([^:]+)$/;

    if ($method) {
        my $plugin = eval { wrapper($self, $method) };
        return $plugin->new(@_, data => $self) if $plugin;
    }

    bbbl'gm::croak
        CORE::sprintf q(Can't locate object method "%s" via package "%s"),
            $method, ((ref $_[0] || $_[0]) || 'main');
}

1;
