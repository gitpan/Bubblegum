use Bubblegum;
use Test::More;

can_ok 'Bubblegum::Object::Undef', 'defined';
subtest 'test the defined method' => sub {
    my $nothing = undef;
    is $nothing->defined, 0;
    $nothing = 'defined';
    is $nothing->defined, 1;
};

done_testing;
