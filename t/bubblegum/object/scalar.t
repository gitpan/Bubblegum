use Bubblegum::Object::Scalar;
use Test::More;

can_ok 'Bubblegum::Object::Scalar', 'and';
can_ok 'Bubblegum::Object::Scalar', 'not';
can_ok 'Bubblegum::Object::Scalar', 'or';
can_ok 'Bubblegum::Object::Scalar', 'repeat';
can_ok 'Bubblegum::Object::Scalar', 'xor';

done_testing;
