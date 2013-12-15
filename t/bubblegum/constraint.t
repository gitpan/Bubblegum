use Bubblegum::Constraint -all;
use Test::More;

can_ok 'Bubblegum::Constraint', 'asa_arrayref';
can_ok 'Bubblegum::Constraint', 'asa_coderef';
can_ok 'Bubblegum::Constraint', 'asa_hashref';
can_ok 'Bubblegum::Constraint', 'asa_number';
can_ok 'Bubblegum::Constraint', 'asa_ref';
can_ok 'Bubblegum::Constraint', 'asa_regexp';
can_ok 'Bubblegum::Constraint', 'asa_string';
can_ok 'Bubblegum::Constraint', 'isa_arrayref';
can_ok 'Bubblegum::Constraint', 'isa_classref';
can_ok 'Bubblegum::Constraint', 'isa_coderef';
can_ok 'Bubblegum::Constraint', 'isa_evenlist';
can_ok 'Bubblegum::Constraint', 'isa_hashref';
can_ok 'Bubblegum::Constraint', 'isa_regexp';

subtest 'testing asa_arrayref' => sub {
    my $a1 = eval { asa_arrayref 123 };
    ok $@, 'asa_arrayref dies';
    my $a2 = eval { asa_arrayref [1,2,3] };
    ok !$@, 'asa_arrayref lives';
    is_deeply $a2, [1,2,3], 'asa_arrayref returns correct value';
};

subtest 'testing asa_coderef' => sub {
    my $c1 = eval { asa_coderef 123 };
    ok $@, 'asa_coderef dies';
    my $c2 = eval { asa_coderef sub {123} };
    ok !$@, 'asa_coderef lives';
    is $c2->(), 123, 'asa_coderef returns correct value';
};

subtest 'testing asa_hashref' => sub {
    my $h1 = eval { asa_hashref 123 };
    ok $@, 'asa_hashref dies';
    my $h2 = eval { asa_hashref {1..4} } or warn $@;
    ok !$@, 'asa_hashref lives';
    is_deeply $h2, {1,2,3,4}, 'asa_hashref returns correct value';
};

subtest 'testing asa_number' => sub {
    my $n1 = eval { asa_number "" };
    ok $@, 'asa_number dies';
    my $n2 = eval { asa_number undef };
    ok $@, 'asa_number dies';
    my $n3 = eval { asa_number 123 };
    ok !$@, 'asa_number lives';
    is $n3, 123, 'asa_number returns correct value';
    my $n4 = eval { asa_number "123" };
    ok !$@, 'asa_number lives';
    is $n4, 123, 'asa_number returns correct value';
    my $n5 = eval { asa_number -123 };
    ok !$@, 'asa_number lives';
    is $n5, -123, 'asa_number returns correct value';
    my $n6 = eval { asa_number -123.365 };
    ok !$@, 'asa_number lives';
    is $n6, -123.365, 'asa_number returns correct value';
};

subtest 'testing asa_ref' => sub {
    my $n1 = eval { asa_ref "" };
    ok $@, 'asa_ref dies';
    my $n2 = eval { asa_ref undef };
    ok $@, 'asa_ref dies';
    my $n3 = eval { asa_ref \123 };
    ok !$@, 'asa_ref lives';
    is_deeply $n3, \123, 'asa_ref returns correct value';
    my $n4 = eval { asa_ref {1..4} };
    ok !$@, 'asa_ref lives';
    is_deeply $n4, {1,2,3,4}, 'asa_ref returns correct value';
    my $n5 = eval { asa_ref sub{0} };
    ok !$@, 'asa_ref lives';
    is_deeply $n5, $n5, 'asa_ref returns correct value';
    my $n6 = eval { asa_ref [0,1] };
    ok !$@, 'asa_ref lives';
    is_deeply $n6, [0,1], 'asa_ref returns correct value';
};

subtest 'testing asa_regexp' => sub {
    my $a1 = eval { asa_regexp 123 };
    ok $@, 'asa_regexp dies';
    my $a2 = eval { asa_regexp qr/123/ };
    ok !$@, 'asa_regexp lives';
    is $a2, qr/123/, 'asa_regexp returns correct value';
};

subtest 'testing asa_string' => sub {
    my $a1 = eval { asa_arrayref 123 };
    ok $@, 'asa_arrayref dies';
    my $a2 = eval { asa_arrayref [1,2,3] };
    ok !$@, 'asa_arrayref lives';
    is_deeply $a2, [1,2,3], 'asa_arrayref returns correct value';
};

subtest 'testing isa_arrayref' => sub {
    ok  isa_arrayref([]), 'returned true';
    ok !isa_arrayref(""), 'returned false';
    ok !isa_arrayref({}), 'returned false';
    ok !isa_arrayref(0), 'returned false';
};

subtest 'testing isa_classref' => sub {
    ok isa_classref(bless {}, main), 'returned true';
    ok !isa_classref({}), 'returned false';
    ok !isa_classref([]), 'returned false';
    ok !isa_classref(1), 'returned false';
};

subtest 'testing isa_coderef' => sub {
    ok isa_coderef(sub { }), 'returned true';
    ok !isa_coderef({}), 'returned false';
    ok !isa_coderef([]), 'returned false';
    ok !isa_coderef(bless {}, main), 'returned false';
};

subtest 'testing isa_evenlist' => sub {
    ok isa_evenlist(1, 2), 'returned true';
    ok !isa_evenlist(1, 2, 3), 'returned false';
    ok !isa_evenlist([]), 'returned false';
    ok !isa_evenlist(0), 'returned false';
};

subtest 'testing isa_hashref' => sub {
    ok isa_hashref({}), 'returned true';
    ok !isa_hashref(""), 'returned false';
    ok !isa_hashref([]), 'returned false';
    ok !isa_hashref(0), 'returned false';
};

subtest 'testing isa_regexp' => sub {
    ok isa_regexp(qr/./), 'returned true';
    ok !isa_regexp(""),   'returned false';
    ok !isa_regexp([]), 'returned false';
    ok !isa_regexp(1), 'returned false';
};

done_testing;
