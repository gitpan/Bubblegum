use Bubblegum;
use Test::More;

ok ! main->isa('Moo::Object'), 'class not an object';

can_ok 'Bubblegum::Object::Universal', 'instance';
can_ok 'Bubblegum::Object::Universal', 'wrapper';

isa_ok(''->wrapper('digest'),  'Bubblegum::Wrapper::Digest');
isa_ok(''->wrapper('dumper'),  'Bubblegum::Wrapper::Dumper');
isa_ok(''->wrapper('encoder'), 'Bubblegum::Wrapper::Encoder');
isa_ok(''->wrapper('json'),    'Bubblegum::Wrapper::Json');
isa_ok(''->wrapper('yaml'),    'Bubblegum::Wrapper::Yaml');

done_testing;
