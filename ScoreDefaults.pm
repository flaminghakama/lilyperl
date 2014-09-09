package ScoreDefaults ; 
sub new {
    my $class = shift;
    my $self = shift ; 
    unless ( ref($self) eq 'HASH' ) { 
        $self = {
            staffSize => $self, 
            barNumberVisibility => shift,
            layout => shift
        } ;
    }
    return bless $self, $class;
}

sub staffSize {
    my ( $self, $value ) = @_; 
    $self->{staffSize} = $value if defined $value ; 
    return $self->{staffSize};
}

sub barNumberVisibility {
    my ( $self, $value ) = @_; 
    $self->{barNumberVisibility} = $value if defined $value ; 
    return $self->{barNumberVisibility};
}

sub layout {
    my ( $self, $value ) = @_; 
    $self->{layout} = $value if defined $value ; 
    return $self->{layout};
}

1 ;
