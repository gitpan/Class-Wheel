use 5.008008;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Class::Wheel',
    VERSION_FROM      => 'lib/Class/Wheel.pm', # finds $VERSION
    PREREQ_PM         => {
        'Error' => 0,
        'Test::Strict' => 0,
	'Class::Accessor::Fast' => 0
    }, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Class/Wheel.pm', # retrieve abstract from module
       AUTHOR         => 'harper <plcgi1@gmail.com>') : ()),
    INC               => '-I.', # e.g., '-I. -I/usr/include/other'
	# Un-comment this if you add C files to link with later:
    # OBJECT            => '$(O_FILES)', # link all the C files too
);
