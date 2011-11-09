#!perl -T

use Test::More tests => 3;

BEGIN {
    use_ok( 'Apache2::Handlers::LogCapture' ) || print "Bail out!\n";
    use_ok( 'Apache2::Handlers::RequestStart' ) || print "Bail out!\n";
    use_ok( 'Apache2::Filter::Input::CapturePost' ) || print "Bail out!\n";
}

diag( "Testing Apache2::Handlers::LogCapture $Apache2::Handlers::LogCapture::VERSION, Perl $], $^X" );
