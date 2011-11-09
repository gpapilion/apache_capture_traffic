package Apache2::Filter::Input::CapturePost;

use 5.006;
use strict;
use warnings;
use base qw(Apache2::Filter);
use Apache2::FilterRec ();
use APR::Brigade ();
use APR::Bucket ();
use APR::BucketType ();
use Apache2::RequestUtil ();

use Apache2::Const -compile => qw(OK DECLINED);
use APR::Const     -compile => ':common';
  
  
sub request {

    # Mostly example code from mod_perl site
    my ($f, $bb, $mode, $block, $readbytes) = @_; # filter args
    # $mode, $block, $readbytes are passed only for input filters
    my $stream = defined $mode ? "input" : "output";
     
    # input filter
    my $rv = $f->next->get_brigade($bb, $mode, $block, $readbytes);
    return $rv unless $rv == APR::Const::SUCCESS;
    copy_post($stream, $bb ,$f );

    # remove from input filter chain, to allow only one run
    # logHandlers rerun the input filter for some reason
    $f->remove(); 
    return Apache2::Const::OK;
}
  
sub copy_post {
    my ($stream, $bb ,$f ) = @_;
    my @data;
    for (my $b = $bb->first; $b; $b = $bb->next($b)) {
        $b->read(my $bdata);
        push @data, $b->type->name, $bdata;
    }
  
    # send the sniffed info to STDERR so not to interfere with normal
    # output
  
    my $request_string = "";
    my $c = 1;
    while (my ($btype, $data) = splice @data, 0, 2) {
        $request_string = "$request_string" .  "$data" ;
        $c++;
    }
    # pushing concated request into pnotes for use by logger
    $f->r->pnotes( "post_data" => $request_string);
}
1;

=head1 NAME

Apache2::Filter::Input::CapturePost - Captures post data from Apache and adds it to pnotes on Apache::RequestUtil object

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

This module captures post data, and adds it the the $request->pnotes data structure 

This is intended for use as an apache Input filter modules


=head1 AUTHOR

Geoffrey Papilion, C<< <papilion at hypergeometric.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-apache2-handlers-logcapture at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Apache2-Handlers-LogCapture>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Apache2::Filter::Input::CapturePost


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

1; # End of Apache2::Filter::Input::CapturePost
