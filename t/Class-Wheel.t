# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Class-Wheel.t'

package Class::Wheel::Subclass;
use strict;
use base 'Class::Wheel';

@__PACKAGE__::FIELDS = qw/fields/;
@__PACKAGE__::STRICT_FIELDS = qw/strict/;

sub init {
    my($self,$param) = @_;
    
    warn "Init method called";
        
    return;
}

sub run {
    my($self,$param) = @_;
    
    warn "Run method called";
    
    return;
}

sub done {
    my($self,$param) = @_;
    
    warn "Done method called";
    
    return;
}

# change 'tests => 1' to 'tests => last_test_to_print';

package main;
use Test::More tests => 3;
use FindBin qw($Bin);
use lib $Bin.'/../lib';
BEGIN { use_ok('Class::Wheel') };

my $obj;
eval { $obj = Class::Wheel::Subclass->new(); };

like($@,qr/\[DIE INIT\]/,"Object must die without required field: strict");

$obj = Class::Wheel::Subclass->new({
    strict => 1
});

is($obj->strict,1,"Check object required field: strict");

$obj->process();

exit(0);
