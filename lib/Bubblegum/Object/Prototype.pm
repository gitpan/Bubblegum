# Base Class for Anonymous Bubblegum Prototype Objects
package Bubblegum::Prototype::Object;

use Bubblegum::Class;

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

1;
