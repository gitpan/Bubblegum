use Bubblegum::Environment;
use Test::More;

can_ok 'Bubblegum::Environment', 'data';
can_ok 'Bubblegum::Environment', 'cwd';
can_ok 'Bubblegum::Environment', 'date';
can_ok 'Bubblegum::Environment', 'date_epoch';
can_ok 'Bubblegum::Environment', 'date_format';
can_ok 'Bubblegum::Environment', 'dump';
can_ok 'Bubblegum::Environment', 'env';
can_ok 'Bubblegum::Environment', 'file';
can_ok 'Bubblegum::Environment', 'find';
can_ok 'Bubblegum::Environment', 'home';
can_ok 'Bubblegum::Environment', 'path';
can_ok 'Bubblegum::Environment', 'quote';
can_ok 'Bubblegum::Environment', 'script';
can_ok 'Bubblegum::Environment', 'unquote';
can_ok 'Bubblegum::Environment', 'user';
can_ok 'Bubblegum::Environment', 'user_info';
can_ok 'Bubblegum::Environment', 'which';

ok my $env = Bubblegum::Environment->new,
    'Bubblegum::Environment instantiated';

isa_ok $env,
    'Bubblegum::Environment';

subtest 'testing cwd' => sub {
    my $path = $env->cwd;
    isa_ok $path, 'Path::Tiny';
};

subtest 'testing date' => sub {
    my $date = $env->date;
    isa_ok $date, 'DateTime::Tiny';

    $date = $env->date('saturday after last');
    is $date, undef, 'The object is undefined, invalid input';
};

subtest 'testing date_epoch' => sub {
    my $date = $env->date_epoch;
    like $date, qr/^\d{5,}$/, 'The routine returned an epoch timestamp';

    $date = $env->date_epoch('saturday after last');
    is $date, undef, 'The object is undefined, invalid input';
};

subtest 'testing date_format' => sub {
    my $date = $env->date_format(time);
    like $date, qr/^\d{4}-\d\d-\d\dT\d\d:\d\d:\d\d$/,
        'The routine returned a formated date-time string';

    $date = $env->date_format;
    is $date, undef, 'The object is undefined, invalid input';
};

subtest 'testing dump' => sub {
    my $dump = $env->dump({1..4});
    like $dump, qr/=> 2/, 'The routine returned a data-dumped string :2';
    like $dump, qr/=> 4/, 'The routine returned a data-dumped string :4';
};

subtest 'testing file' => sub {
    my $file = $env->file($0);
    isa_ok $file, 'Path::Tiny';
};

subtest 'testing find' => sub {
    my $files = $env->find($0);
    isa_ok $files->[0], 'Path::Tiny';
};

subtest 'testing home' => sub {
    my $path = $env->home;
    isa_ok $path, 'Path::Tiny' if $path;
};

subtest 'testing lib' => sub {
    my $lib = $env->lib;
    ok ! ref $lib, 'lib always returns stringified';
};

subtest 'testing path' => sub {
    my $path = $env->path('.');
    isa_ok $path, 'Path::Tiny';
};

subtest 'testing quote' => sub {
    my $string = $env->quote('routine "testing"');
    is $string, '"routine \"testing\""', 'quotes strings';
};

subtest 'testing script' => sub {
    my $script = $env->script;
    isa_ok $script, 'Path::Tiny';
};

subtest 'testing unquote' => sub {
    my $string = $env->unquote('"testing"');
    is $string, 'testing', 'removes quotes';
};

subtest 'testing user' => sub {
    my $user = $env->user;
    like $user, qr/^\w{1,}$/, 'returns the username'
};

subtest 'testing user_info' => sub {
    my $user = $env->user_info;
    ok scalar @$user, 'returns user info';
};

subtest 'testing which' => sub {
    my $perl = $env->which('perl');
    isa_ok $perl, 'Path::Tiny';
};

done_testing;
