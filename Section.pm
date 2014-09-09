package Section ; 
use Instrument ; 

sub new {
    my $class = shift;
    my $self = shift ; 
    unless ( ref($self) eq 'HASH' ) { 
        $self = {
            name => $self, 
            displayName => shift,
            key => shift, 
            tempo => shift, 
            timeSignature => shift,
            howManyMeasures => shift,
            defaultMusic => shift,
            defaultChords => shift
        } ; 
    }
    return bless $self, $class;
}

sub name {
    my ( $self, $value ) = @_; 
    $self->{name} = $value if defined $value ; 
    return $self->{name};
}

#
#  This should take a few values:
#      '#'      : print the measure number as a rehearsal mark
#      'alpha'  : print 
#      'NAME'   : use the actual section name
#  Any other value is used literally
#
sub displayName {
    my ( $self, $value ) = @_; 
    $self->{displayName} = $value if defined $value ; 
    return $self->{displayName};
}

sub key {
    my ( $self, $value ) = @_; 
    $self->{key} = $value if defined $value ; 
    return $self->{key};
}

sub tempo {
    my ( $self, $value ) = @_; 
    $self->{tempo} = $value if defined $value ; 
    return $self->{tempo};
}

sub timeSignature {
    my ( $self, $value ) = @_; 
    $self->{timeSignature} = $value if defined $value ; 
    return $self->{timeSignature};
}

sub howManyMeasures {
    my ( $self, $value ) = @_; 
    $self->{howManyMeasures} = $value if defined $value ; 
    return $self->{howManyMeasures};
}

sub defaultMusic {
    my ( $self, $value ) = @_; 
    $self->{defaultMusic} = $value if defined $value ; 
    return $self->{defaultMusic};
}

sub defaultChords {
    my ( $self, $value ) = @_; 
    $self->{defaultChords} = $value if defined $value ; 
    return $self->{defaultChords};
}

1 ;