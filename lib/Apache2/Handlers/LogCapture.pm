package Apache2::Handler::LogCapture;

use Apache2::Const qw(:common);
use Time::HiRes qw(time);
use Apache2::RequestUtil;
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
    my $log_string = "\n$envs====\n" . $date . "\n" . $elapsed_time . "\n" . $bytes . "\n" . $request . "\n" . $headers_as_string . "\n" . $r->pnotes("post_data") . "\n"  . "\n" . $status . "\n" ;
    print LOGFILE  $log_string;
    close LOGFILE;
    return OK;
}

1;
