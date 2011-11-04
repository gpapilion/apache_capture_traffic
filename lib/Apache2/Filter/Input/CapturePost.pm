package Apache2::Filter::Input::CapturePost;
  
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
