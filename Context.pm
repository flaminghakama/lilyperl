package Context ; 

sub new {
    my $class = shift;
    my $self = shift ; 

    unless (  ref($self) eq 'HASH' ) { 
        $self = {
            context => $self,
            value => shift
        } ; 
    }
    
    return bless $self, $class;
}

sub context {
    my ( $self, $value ) = @_; 
    $self->{context} = $value if defined $value ; 
    return $self->{context};
}

sub value {
    my ( $self, $value ) = @_; 
    $self->{value} = $value if defined $value ; 
    return $self->{value};
}

1 ; 
