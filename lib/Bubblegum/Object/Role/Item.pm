package Bubblegum::Object::Role::Item;

use 5.10.0;
use Bubblegum::Role 'requires';
use Bubblegum::Namespace;

use Types::Standard ();

our $VERSION = '0.28'; # VERSION

requires 'defined';

*asa_aref       = \&Types::Standard::assert_ArrayRef;
*asa_arrayref   = \&Types::Standard::assert_ArrayRef;
*asa_bool       = \&Types::Standard::assert_Bool;
*asa_boolean    = \&Types::Standard::assert_Bool;
*asa_class      = \&Types::Standard::assert_ClassName;
*asa_classname  = \&Types::Standard::assert_ClassName;
*asa_coderef    = \&Types::Standard::assert_CodeRef;
*asa_cref       = \&Types::Standard::assert_CodeRef;
*asa_def        = \&Types::Standard::assert_Defined;
*asa_defined    = \&Types::Standard::assert_Defined;
*asa_fh         = \&Types::Standard::assert_FileHandle;
*asa_filehandle = \&Types::Standard::assert_FileHandle;
*asa_glob       = \&Types::Standard::assert_GlobRef;
*asa_globref    = \&Types::Standard::assert_GlobRef;
*asa_hashref    = \&Types::Standard::assert_HashRef;
*asa_href       = \&Types::Standard::assert_HashRef;
*asa_int        = \&Types::Standard::assert_Int;
*asa_integer    = \&Types::Standard::assert_Int;
*asa_nil        = \&Types::Standard::assert_Undef;
*asa_null       = \&Types::Standard::assert_Undef;
*asa_num        = \&Types::Standard::assert_Num;
*asa_number     = \&Types::Standard::assert_Num;
*asa_obj        = \&Types::Standard::assert_Object;
*asa_object     = \&Types::Standard::assert_Object;
*asa_ref        = \&Types::Standard::assert_Ref;
*asa_reference  = \&Types::Standard::assert_Ref;
*asa_regexpref  = \&Types::Standard::assert_RegexpRef;
*asa_rref       = \&Types::Standard::assert_RegexpRef;
*asa_scalarref  = \&Types::Standard::assert_ScalarRef;
*asa_sref       = \&Types::Standard::assert_ScalarRef;
*asa_str        = \&Types::Standard::assert_Str;
*asa_string     = \&Types::Standard::assert_Str;
*asa_undef      = \&Types::Standard::assert_Undef;
*asa_undefined  = \&Types::Standard::assert_Undef;
*asa_val        = \&Types::Standard::assert_Value;
*asa_value      = \&Types::Standard::assert_Value;
*isa_aref       = \&Types::Standard::is_ArrayRef;
*isa_arrayref   = \&Types::Standard::is_ArrayRef;
*isa_bool       = \&Types::Standard::is_Bool;
*isa_boolean    = \&Types::Standard::is_Bool;
*isa_class      = \&Types::Standard::is_ClassName;
*isa_classname  = \&Types::Standard::is_ClassName;
*isa_coderef    = \&Types::Standard::is_CodeRef;
*isa_cref       = \&Types::Standard::is_CodeRef;
*isa_def        = \&Types::Standard::is_Defined;
*isa_defined    = \&Types::Standard::is_Defined;
*isa_fh         = \&Types::Standard::is_FileHandle;
*isa_filehandle = \&Types::Standard::is_FileHandle;
*isa_glob       = \&Types::Standard::is_GlobRef;
*isa_globref    = \&Types::Standard::is_GlobRef;
*isa_hashref    = \&Types::Standard::is_HashRef;
*isa_href       = \&Types::Standard::is_HashRef;
*isa_int        = \&Types::Standard::is_Int;
*isa_integer    = \&Types::Standard::is_Int;
*isa_nil        = \&Types::Standard::is_Undef;
*isa_null       = \&Types::Standard::is_Undef;
*isa_num        = \&Types::Standard::is_Num;
*isa_number     = \&Types::Standard::is_Num;
*isa_obj        = \&Types::Standard::is_Object;
*isa_object     = \&Types::Standard::is_Object;
*isa_ref        = \&Types::Standard::is_Ref;
*isa_reference  = \&Types::Standard::is_Ref;
*isa_regexpref  = \&Types::Standard::is_RegexpRef;
*isa_rref       = \&Types::Standard::is_RegexpRef;
*isa_scalarref  = \&Types::Standard::is_ScalarRef;
*isa_sref       = \&Types::Standard::is_ScalarRef;
*isa_str        = \&Types::Standard::is_Str;
*isa_string     = \&Types::Standard::is_Str;
*isa_undef      = \&Types::Standard::is_Undef;
*isa_undefined  = \&Types::Standard::is_Undef;
*isa_val        = \&Types::Standard::is_Value;
*isa_value      = \&Types::Standard::is_Value;

sub class {
    my $self  = CORE::shift;
    my $types = $Bubblegum::Namespace::DefaultTypes;
    return $types->{type($self)};
}

sub of {
    my $self  = CORE::shift;
    my $type  = CORE::shift;
    my $types = $Bubblegum::Namespace::DefaultTypes;

    my $alias = {
        aref  => 'array',
        cref  => 'code',
        href  => 'hash',
        int   => 'integer',
        nil   => 'undef',
        null  => 'undef',
        num   => 'number',
        str   => 'string',
        undef => 'undef',
    };

    $type = $alias->{lc $type} if $alias->{lc $type};

    my $kind  = $types->{uc $type};
    my $class = $self->autobox_class;

    return $kind && $class->isa($kind) ? 1 : 0;
}

sub type {
    my $self = CORE::shift;
    return autobox::universal::type $self;
}

sub typeof {
    goto &of;
}

1;
