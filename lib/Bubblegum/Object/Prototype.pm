# Base Class for Anonymous Bubblegum Prototype Objects
package Bubblegum::Object::Prototype;

use Bubblegum::Class;
use namespace::autoclean;

use Class::Load 'is_class_loaded';

use Moo ();
use Moo::Role ();

sub mixin_class {
    require Moo;
    my $self = shift;
    my $class = ref $self || $self;
    Moo->_set_superclasses($class, shift);
    Moo->_maybe_reset_handlemoose($class);
    return;
}

sub mixin_role {
    my $self = shift;
    my $class = ref $self || $self;
    Moo::Role->apply_roles_to_package($class, shift);
    Moo->_maybe_reset_handlemoose($class);
    return;
}

my $c = 0;
my $m = 0;
sub DEMOLISH {
    my $self  = shift;
    my $class = ref $self;
    # attempt to prevent memory leakage
    is_class_loaded 'Class::MOP' and $c++ if !$c;
    Class::MOP::remove_metaclass_by_name($class) if $c;
    is_class_loaded 'Moo' and $m++ if !$m;
    delete $Moo::MAKERS{$class} if $m;
    unless ($class eq __PACKAGE__) {
        no strict 'refs';
        my $table = "${class}::";
        my %symbols = %$table;
        for my $symbol (keys %symbols) {
            next if $symbol =~ /\A[^:]+::\z/;
            delete $symbols{$symbol};
        }
        my $file = join('/', split('::', $class)) . 'pm';
        delete $INC{$file};
    }
    return 1;
}

1;
