package # hide from PAUSE
    utf8::all::Conflicts;

use strict;
use warnings;

use Dist::CheckConflicts
    -dist      => 'utf8::all',
    -conflicts => {
        'autodie' => '2.11',
    },

;

1;

# ABSTRACT: Provide information on conflicts for utf8::all

__END__

=pod

=encoding utf-8

=head1 NAME

utf8::all::Conflicts - Provide information on conflicts for utf8::all

=head1 VERSION

version 0.011

=head1 AVAILABILITY

The project homepage is L<http://metacpan.org/release/utf8-all/>.

The latest version of this module is available from the Comprehensive Perl
Archive Network (CPAN). Visit L<http://www.perl.com/CPAN/> to find a CPAN
site near you, or see L<https://metacpan.org/module/utf8::all/>.

=head1 SOURCE

The development version is on github at L<http://github.com/doherty/utf8-all>
and may be cloned from L<git://github.com/doherty/utf8-all.git>

=head1 BUGS AND LIMITATIONS

You can make new bug reports, and view existing ones, through the
web interface at L<https://github.com/doherty/utf8-all/issues>.

=head1 AUTHORS

=over 4

=item *

Michael Schwern <mschwern@cpan.org>

=item *

Mike Doherty <doherty@cpan.org>

=back

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Michael Schwern <mschwern@cpan.org>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
