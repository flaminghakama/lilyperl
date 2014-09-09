package MusicDefinitions ; 

sub new {
    my $class = shift;
    my $self = shift ; 
    my @definitionsFunctions ;
    my @staffGroupIncludes ;
    unless( ref($self) eq 'HASH' ) { 
        $self = {
            functions => $self, 
            functionsFilename => shift, 
            functionsInclude => shift, 
            staffGroupIncludes => shift 
        } ; 
    }
    $self->{functions} = \@functions ; 
    $self->{staffGroupIncludes} = \@staffGroupIncludes ; 
    return bless $self, $class;
}

sub functions {
    my ( $self, $value ) = @_; 
    $self->{functions} = $value if defined $value ; 
    return $self->{functions};
}

sub pushFunction {
    my ( $self, @values ) = @_; 
    my (@functions) = $self->{functions} ; 
    if ( @values ) { 
        push( @functions, @values) ; 
        $self->{functions} = \@functions ; 
    }
    return $self->{functions};
}

sub functionsFilename {
    my ( $self, $value ) = @_; 
    $self->{functionsFilename} = $value if defined $value ; 
    return $self->{functionsFilename};
}

sub functionsInclude {
    my ( $self, $value ) = @_; 
    $self->{functionsInclude} = $value if defined $value ; 
    return $self->{functionsInclude};
}

sub staffGroupIncludes {
    my ( $self, $value ) = @_; 
    $self->{staffGroupIncludes} = $value if defined $value ; 
    return $self->{staffGroupIncludes};
}

sub pushStaffGroupIncludes {
    my ( $self, @values ) = @_; 
    my (@staffGroupIncludes) = $self->{staffGroupIncludes} ; 
    if ( @values ) { 
        push( @staffGroupIncludes, @values) ; 
        $self->{staffGroupIncludes} = \@staffGroupIncludes ; 
    }
    return $self->{staffGroupIncludes};
}

1 ; 
