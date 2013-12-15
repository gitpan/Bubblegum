use Bubblegum::Role::Configuration;
use Test::More;

can_ok 'bbbl::gm', 'chk';
can_ok 'bbbl::gm', 'chkarray';
can_ok 'bbbl::gm', 'chkcode';
can_ok 'bbbl::gm', 'chkhash';
can_ok 'bbbl::gm', 'chknum';
can_ok 'bbbl::gm', 'chkref';
can_ok 'bbbl::gm', 'chkre';
can_ok 'bbbl::gm', 'chkstr';
can_ok 'bbbl::gm', 'croak';
can_ok 'bbbl::gm', 'forward';
can_ok 'bbbl::gm', 'instance';
can_ok 'bbbl::gm', 'load';
can_ok 'bbbl::gm', 'mappings';

can_ok 'Bubblegum::Role::Configuration', 'check';
can_ok 'Bubblegum::Role::Configuration', 'forward';
can_ok 'Bubblegum::Role::Configuration', 'instance';
can_ok 'Bubblegum::Role::Configuration', 'load';
can_ok 'Bubblegum::Role::Configuration', 'mappings';
can_ok 'Bubblegum::Role::Configuration', 'prerequisites';

done_testing;
