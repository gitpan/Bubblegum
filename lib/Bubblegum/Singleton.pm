package Bubblegum::Singleton;

use Moo 'with';

with 'Bubblegum::Role::Configuration';

our $VERSION = '0.08'; # VERSION

sub import {
    my $target = caller;
    my $class  = shift;
    my @export = @_;

    $class->prerequisites($target);
    Moo->import::into($target, @export);

    my $inst;
    my $orig = $class->can('new');
    no strict 'refs';
    *{"${target}::new"} = sub {
        $inst //= $orig->(@_)
    };

    if (!$class->can('renew')) {
        *{"${target}::renew"} = sub {
            $inst = $orig->(@_)
        };
    }
}

1;
