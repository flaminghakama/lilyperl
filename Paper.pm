package Paper;

sub new {
    my $class = shift;
    my $self = shift ; 
    unless ( ref($self) eq 'HASH' ) { 
        $self = {
            size        => $self,
            orientation => shift
        };
    }
    return bless $self, $class;
}

sub definePaperSize {
    my ( $self, $value ) = @_; 
    $self->{definition} = $value if defined $value ; 
    return $self->{definition};
}

sub size {
    my ( $self, $value ) = @_; 
    $self->{size} = $value if defined $value ; 
    return $self->{size};
}

sub orientation {
    my ( $self, $value ) = @_; 
    $self->{orientation} = $value if defined $value ; 
    return $self->{orientation};
}

sub render { 
    my $self = shift ; 
    my @lilypond = () ;

    if ( defined $self->{definition} ) { 
        push ( @lilypond, $self->{definition} ) ; 
    }

    push ( @lilypond, 
           "#(set-default-paper-size \"" . $self->{size} . "\" '" . $self->{orientation} . ")" ) ;

    return @lilypond ;  
}

1;
