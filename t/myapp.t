BEGIN {
    use FindBin;
    use lib $FindBin::Bin . '/myapp/lib';
}

use MyApp::Core;
use Test::More;

ok ! main->isa('Moo::Object'), 'class not an object';

ok 'a'->digest,  'Bubblegum::Wrapper::Digest invoked';
ok [1]->dumper,  'Bubblegum::Wrapper::Dumper invoked';
ok 'a'->encoder, 'Bubblegum::Wrapper::Encoder invoked';
ok [1]->json,    'Bubblegum::Wrapper::Json invoked';
ok [1]->yaml,    'Bubblegum::Wrapper::Yaml invoked';

my $string = "foo bar baz";
is_deeply $string->words, ["foo", "bar", "baz"];
is $string->proper, 5678;

done_testing;
