package Class::Wheel;
use strict;
use Class::Accessor::Fast;
use base qw/Class::Accessor::Fast Error/;

$__PACKAGE__::VERSION = '0.02';

@__PACKAGE__::FIELDS = qw//;
@__PACKAGE__::STRICT_FIELDS = qw//;

sub new {
    my($class,$param) = @_;
    my $self = $class->SUPER::new();
    bless $self,$class;
    
    $self->_setFields(\@__PACKAGE__::STRICT_FIELDS,\@__PACKAGE__::FIELDS);
        
    __PACKAGE__->mk_accessors(@__PACKAGE__::STRICT_FIELDS,@__PACKAGE__::FIELDS);
        
    foreach ( @{$self->{strictFields}} ){
        if( defined $param->{$_} ){
            $self->$_($param->{$_});
        }
        else {
            die "[DIE INIT]: You must define value for $_";
        }
    }
    
    $self->init($param);
    
    return $self;
}

sub init {
    my($self,$param) = @_;

    foreach (keys %$param) {
        if( grep $_,@{$self->{fields}} ) {
            $self->$_($param->{$_});   
        }
        else {
            $self->{$_} = $param->{$_};
        }    
    }    
    return;
}

sub process {
    my($self,$param)=@_;
    $self->run($param);
    $self->done();
}

sub run {
    my($self,$param)=@_;
    return;
}

sub done {
    my($self)=@_;
    return;
}

sub _setFields {
    my($self,$strict,$field)=@_;
    
    $self->{strictFields} = $strict;
    $self->{fields} = $field;
    
    return;
}

1;

__END__

=head1 NAME

Class::Wheel - simple class wheel

=head1 SYNOPSIS
  
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

    package main;
        
    my $obj = Class::Wheel::Subclass->new({
        strict => 1
    });
    
    $obj->process(); # run init run done
    
=head1 DESCRIPTION
   
  Class::Wheel  - simple class wheel
  You can divide creating object with some logic to some steps : init,run,done
  and run these methods in method process
  Usually if you need your own extra initialization - you can redefine method init
  Logic for object - in method run
  Some finalize actions you can define in method done

=head1 AUTHOR

E<lt>plcgi1@gmail.com<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 by plcgi1@gmail.com

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.


=cut
