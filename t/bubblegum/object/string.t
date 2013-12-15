use Bubblegum::Object::String;
use Test::More;

can_ok 'Bubblegum::Object::String', 'eq';
can_ok 'Bubblegum::Object::String', 'eqtv';
can_ok 'Bubblegum::Object::String', 'gt';
can_ok 'Bubblegum::Object::String', 'gte';
can_ok 'Bubblegum::Object::String', 'lt';
can_ok 'Bubblegum::Object::String', 'lte';
can_ok 'Bubblegum::Object::String', 'ne';
can_ok 'Bubblegum::Object::String', 'camelcase';
can_ok 'Bubblegum::Object::String', 'chomp';
can_ok 'Bubblegum::Object::String', 'chop';
can_ok 'Bubblegum::Object::String', 'index';
can_ok 'Bubblegum::Object::String', 'lc';
can_ok 'Bubblegum::Object::String', 'lcfirst';
can_ok 'Bubblegum::Object::String', 'length';
can_ok 'Bubblegum::Object::String', 'lines';
can_ok 'Bubblegum::Object::String', 'lowercase';
can_ok 'Bubblegum::Object::String', 'reverse';
can_ok 'Bubblegum::Object::String', 'rindex';
can_ok 'Bubblegum::Object::String', 'snakecase';
can_ok 'Bubblegum::Object::String', 'split';
can_ok 'Bubblegum::Object::String', 'strip';
can_ok 'Bubblegum::Object::String', 'titlecase';
can_ok 'Bubblegum::Object::String', 'to_array';
can_ok 'Bubblegum::Object::String', 'to_code';
can_ok 'Bubblegum::Object::String', 'to_hash';
can_ok 'Bubblegum::Object::String', 'to_integer';
can_ok 'Bubblegum::Object::String', 'to_string';
can_ok 'Bubblegum::Object::String', 'trim';
can_ok 'Bubblegum::Object::String', 'uc';
can_ok 'Bubblegum::Object::String', 'ucfirst';
can_ok 'Bubblegum::Object::String', 'uppercase';
can_ok 'Bubblegum::Object::String', 'words';

done_testing;