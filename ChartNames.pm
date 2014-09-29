package ChartNames ; 

sub new {
    my $class = shift;
    my $self = shift ; 
    unless ( ref($self) eq 'HASH' ) { 
        $self = {
            chartName => $self,
            pdfFileSuffix => shift, 
            visiblePartName   => shift
        } ;
    }
    return bless $self, $class;
}

sub chartName {
    my ( $self, $value ) = @_;
    $self->{chartName} = $value if defined $value ; 
    return $self->{chartName} ;
}

sub pdfFileSuffix {
    my ( $self, $value ) = @_;
    $self->{pdfFileSuffix} = $value if defined $value ; 
    return $self->{pdfFileSuffix} ;
}

sub visiblePartName {
    my ( $self, $value ) = @_; 
    $self->{visiblePartName} = $value if defined $value ; 
    return $self->{visiblePartName} ; 
}

1 ; 

