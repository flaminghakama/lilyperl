package PartNames ; 

sub new {
    my $class = shift;
    my $self = shift ; 
    unless ( ref($self) eq 'HASH' ) { 
        $self = {
            variableName => $self,
            pdfSuffix    => shift, 
            pdfPart      => shift
        } ;
    }
    return bless $self, $class;
}


sub variableName {
    my ( $self, $value ) = @_;
    $self->{variableName} = $value if defined $value ; 
    return $self->{variableName} ;
}

sub pdfSuffix {
    my ( $self, $value ) = @_;
    $self->{pdfSuffix} = $value if defined $value ; 
    return $self->{pdfSuffix} ;
}

sub pdfPart {
    my ( $self, $value ) = @_; 
    $self->{pdfPart} = $value if defined $value ; 
    return $self->{pdfPart} ; 
}

1 ; 

