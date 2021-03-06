package Apache2::Handlers::RequestStart;

use 5.006;
use strict;
use warnings;
use Time::HiRes qw(time);
use Apache2::RequestRec ();
use Apache2::Const qw(:common);

sub handler {
   my $r = shift;
   # use hires time;
   $r->pnotes( "hires_start" => time() );
   return OK;
}

=head1 NAME

Apache2::Handlers::RequestStart - Adds Start Time to Apache::RequestUtil->{pnotes}

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

This module is used to add a high precision timer to the pnotes object 
for later logging.

=head1 AUTHOR

Geoffrey Papilion, C<< <papilion at hypergeometric.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-apache2-handlers-logcapture at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Apache2-Handlers-LogCapture>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Apache2::Handlers::RequestStart


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Apache2-Handlers-LogCapture>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Apache2-Handlers-LogCapture>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Apache2-Handlers-LogCapture>

=item * Search CPAN

L<http://search.cpan.org/dist/Apache2-Handlers-LogCapture/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2011 Geoffrey Papilion.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of Apache2::Handlers::RequestStart
