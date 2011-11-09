package Apache2::Handlers::LogCapture;

use 5.006;
use strict;
use warnings;
use Time::HiRes qw(time);
use Apache2::RequestUtil;
use Apache2::Const qw(:common);

sub handler {
    my $r = shift;
    my $log_file = $r->dir_config("CaptureLog");;
    my $elapsed_time = time() - $r->pnotes("hires_start");
    my $request = $r->the_request;
    my $headers = $r->headers_in;
    my $uri     = $r->uri;
    my $bytes   = $r->bytes_sent;
    my $args = $r->args();
    my $c = $r->connection();
    my $remote  = $c->get_remote_host;
    my $status  = $r->status_line;
    my $date    = localtime;
    my $headers_as_string = ""; 
    foreach my $header (keys %{$headers}){
       $headers_as_string = $headers_as_string . $header . ": " . $headers->{$header} . "\n";
    }

    open(LOGFILE, ">>", $log_file );
    my $log_string = "====\a" . $date . "\a" . $elapsed_time . "\a" . $bytes . "\a" . $request . "\a" . $headers_as_string . "\a" . $r->pnotes("post_data") . "\a"  . "\a" . $status . "\n";
    print LOGFILE  $log_string;
    close LOGFILE;
    return OK;
}

=head1 NAME

Apache2::Handlers::LogCapture - Module to log full Apache requestLogCapture!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

This module adds additional logging to apache to capture a replayable request. 

=head1 AUTHOR

Geoffrey Papilion, C<< <papilion at hypergeometric.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-apache2-handlers-logcapture at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Apache2-Handlers-LogCapture>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Apache2::Handlers::LogCapture


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

1; # End of Apache2::Handlers::LogCapture
