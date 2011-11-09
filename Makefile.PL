use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Apache2::Handlers::LogCapture',
    AUTHOR              => q{Geoffrey Papilion <papilion@hypergeometric.com>},
    VERSION_FROM        => 'lib/Apache2/Handlers/LogCapture.pm',
    ABSTRACT_FROM       => 'lib/Apache2/Handlers/LogCapture.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
	'Apache2::RequestUtil' => 0,
	'Time::HiRes' => 0, 
	'APR::Brigade' => 0,
	'APR::Bucket' => 0,
	'APR::BucketType' => 0
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Apache2-Handlers-LogCapture-*' },
);
