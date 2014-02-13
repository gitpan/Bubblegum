use Bubblegum;
use Test::More;

can_ok 'Bubblegum::Object::Number', 'abs';
subtest 'test the abs method' => sub {
    my $number = 12;
    is 12, $number->abs; # 12

    $number = -12;
    is 12, $number->abs; # 12
};

can_ok 'Bubblegum::Object::Number', 'atan2';
subtest 'test the atan2 method' => sub {
    my $number = 1;
    is 0.785398163397448, $number->atan2(1); # 0.785398163397448
};

can_ok 'Bubblegum::Object::Number', 'cos';
subtest 'test the cos method' => sub {
    my $number = 12;
    is 0.843853958732492, $number->cos; # 0.843853958732492
};

can_ok 'Bubblegum::Object::Number', 'decr';
subtest 'test the decr method' => sub {
    my $number = 123456789;
    is 123456788, $number->decr; # 123456788
};

can_ok 'Bubblegum::Object::Number', 'exp';
subtest 'test the exp method' => sub {
    my $number = 0;
    is 1, $number->exp; # 1

    $number = 1;
    is 2.71828182845905, $number->exp; # 2.71828182845905

    $number = 1.5;
    is 4.48168907033806, $number->exp; # 4.48168907033806
};

can_ok 'Bubblegum::Object::Number', 'hex';
subtest 'test the hex method' => sub {
    my $number = 175;
    is '0xaf', $number->hex; # 0xaf
};

can_ok 'Bubblegum::Object::Number', 'incr';
subtest 'test the incr method' => sub {
    my $number = 123456789;
    is 123456790, $number->incr; # 123456790
};

can_ok 'Bubblegum::Object::Number', 'int';
subtest 'test the int method' => sub {
    my $number = 12.5;
    is 12, $number->int; # 12
};

can_ok 'Bubblegum::Object::Number', 'log';
subtest 'test the log method' => sub {
    my $number = 12345;
    is 9.42100640177928, $number->log; # 9.42100640177928
};

can_ok 'Bubblegum::Object::Number', 'mod';
subtest 'test the mod method' => sub {
    my $number = 12;
    is 0, $number->mod(1); # 0
    is 0, $number->mod(2); # 0
    is 0, $number->mod(3); # 0
    is 0, $number->mod(4); # 0
    is 2, $number->mod(5); # 2
};

can_ok 'Bubblegum::Object::Number', 'neg';
subtest 'test the neg method' => sub {
    my $number = 12345;
    is -12345, $number->neg; # -12345
};

can_ok 'Bubblegum::Object::Number', 'pow';
subtest 'test the pow method' => sub {
    my $number = 12345;
    is 1881365963625, $number->pow(3); # 1881365963625
};

can_ok 'Bubblegum::Object::Number', 'sin';
subtest 'test the sin method' => sub {
    my $number = 12345;
    is -0.993771636455681, $number->sin; # -0.993771636455681
};

can_ok 'Bubblegum::Object::Number', 'sqrt';
subtest 'test the sqrt method' => sub {
    my $number = 12345;
    is 111.108055513541, $number->sqrt; # 111.108055513541
};

done_testing;
