use Bubblegum::Object::Integer;
use Test::More;

can_ok 'Bubblegum::Object::Integer', 'downto';
can_ok 'Bubblegum::Object::Integer', 'eq';
can_ok 'Bubblegum::Object::Integer', 'eqtv';
can_ok 'Bubblegum::Object::Integer', 'gt';
can_ok 'Bubblegum::Object::Integer', 'gte';
can_ok 'Bubblegum::Object::Integer', 'lt';
can_ok 'Bubblegum::Object::Integer', 'lte';
can_ok 'Bubblegum::Object::Integer', 'ne';
can_ok 'Bubblegum::Object::Integer', 'to';
can_ok 'Bubblegum::Object::Integer', 'to_array';
can_ok 'Bubblegum::Object::Integer', 'to_code';
can_ok 'Bubblegum::Object::Integer', 'to_hash';
can_ok 'Bubblegum::Object::Integer', 'to_integer';
can_ok 'Bubblegum::Object::Integer', 'to_string';
can_ok 'Bubblegum::Object::Integer', 'upto';

done_testing;
