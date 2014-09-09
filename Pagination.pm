package Pagination ; 

sub new {
    my $class = shift;
    my $self = shift ; 
    unless ( ref($self) eq 'HASH' ) { 
        $self = {
            printPageNumberFirst => $self, 
            printPageNumberNext => shift,
            titleSplitLeft => shift,
            titleSplitRight  => shift
        } ; 
    } 
    return bless $self, $class;
}

sub printPageNumberFirst {
    my ( $self, $value ) = @_; 
    $self->{printPageNumberFirst} = $value if defined $value ; 
    return $self->{printPageNumberFirst};
}

sub printPageNumberNext {
    my ( $self, $value ) = @_; 
    $self->{printPageNumberNext} = $value if defined $value ; 
    return $self->{printPageNumberNext};
}

sub titleSplitLeft {
    my ( $self, $value ) = @_; 
    $self->{titleSplitLeft} = $value if defined $value ; 
    return $self->{titleSplitLeft};
}

sub titleSplitRight {
    my ( $self, $value ) = @_; 
    $self->{titleSplitRight} = $value if defined $value ; 
    return $self->{titleSplitRight};
}

1 ;
