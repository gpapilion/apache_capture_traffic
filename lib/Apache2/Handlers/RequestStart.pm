package Apache2::Handler::RequestStart;
# super simple handler to be run at 

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

1;
