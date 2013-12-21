use Bubblegum::Role::Configuration;
use Test::More;

can_ok 'bbblgm', 'chk';
can_ok 'bbblgm', 'chkarray';
can_ok 'bbblgm', 'chkcode';
can_ok 'bbblgm', 'chkhash';
can_ok 'bbblgm', 'chknum';
can_ok 'bbblgm', 'chkref';
can_ok 'bbblgm', 'chkre';
can_ok 'bbblgm', 'chkstr';
can_ok 'bbblgm', 'croak';
can_ok 'bbblgm', 'forward';
can_ok 'bbblgm', 'instance';
can_ok 'bbblgm', 'load';
can_ok 'bbblgm', 'mappings';

can_ok 'Bubblegum::Role::Configuration', 'check';
can_ok 'Bubblegum::Role::Configuration', 'forward';
can_ok 'Bubblegum::Role::Configuration', 'instance';
can_ok 'Bubblegum::Role::Configuration', 'load';
can_ok 'Bubblegum::Role::Configuration', 'mappings';
can_ok 'Bubblegum::Role::Configuration', 'prerequisites';

done_testing;
