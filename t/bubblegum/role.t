use Bubblegum::Role;
use Test::More;

can_ok 'main', 'has';
can_ok 'main', 'with';
can_ok 'main', 'requires';

ok defined($*), 'dollar-star is defined';
isa_ok ref($*), 'Bubblegum::Environment', 'dollar-star isa is correct';

done_testing;
