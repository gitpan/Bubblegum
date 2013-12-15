use Bubblegum::Object::Code;
use Test::More;

can_ok 'Bubblegum::Object::Code', 'call';
can_ok 'Bubblegum::Object::Code', 'curry';
can_ok 'Bubblegum::Object::Code', 'rcurry';
can_ok 'Bubblegum::Object::Code', 'compose';
can_ok 'Bubblegum::Object::Code', 'disjoin';
can_ok 'Bubblegum::Object::Code', 'conjoin';
can_ok 'Bubblegum::Object::Code', 'next';

done_testing;
