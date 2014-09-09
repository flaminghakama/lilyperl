package Space ; 

sub new {
    my $class = shift;
    my $self = shift ; 
    unless ( ref($self) eq 'HASH' ) { 
        $self = {
            afterHeaderFirstPage => $self, 
            afterHeaderNextPage => shift, 
            betweenSystems => shift, 
            betweenTopOfPageAndHeader => shift 
        } ; 
    }
    return bless $self, $class;
}

sub afterHeaderFirstPage {
    my ( $self, $value ) = @_; 
    $self->{afterHeaderFirstPage} = $value if defined $value ; 
    return $self->{afterHeaderFirstPage};
}

sub afterHeaderNextPage {
    my ( $self, $value ) = @_; 
    $self->{afterHeaderNextPage} = $value if defined $value ; 
    return $self->{afterHeaderNextPage};
}

sub betweenSystems {
    my ( $self, $value ) = @_; 
    $self->{betweenSystems} = $value if defined $value ; 
    return $self->{betweenSystems};
}

sub betweenTopOfPageAndHeader {
    my ( $self, $value ) = @_; 
    $self->{betweenTopOfPageAndHeader} = $value if defined $value ; 
    return $self->{betweenTopOfPageAndHeader};
}

sub render {
    my $self = shift ; 
    my $margin = shift ; 
    my $indent = $margin . '    ' ;
    my @lilypond = ( ) ; 
    if ( $self->afterHeaderFirstPage() ) {
        push( @lilypond, $indent . "markup-system-spacing #'padding = #" . $self->afterHeaderFirstPage() ) ; 
    }
    if ( $self->afterHeaderNextPage() ) { 
        push( @lilypond, $indent . "top-system-spacing #'minimum-distance = #" . $self->afterHeaderNextPage() ) ; 
    }
    if ( $self->betweenSystems() ) {
        push( @lilypond, $indent . "system-system-spacing #'basic-distance = #" . $self->betweenSystems() ) ; 
    }
    if ( $self->betweenTopOfPageAndHeader() ) { 
        push( @lilypond, $indent . "top-margin = #" . $self->betweenTopOfPageAndHeader() ) ; 
    }

    return @lilypond ; 
}

1 ;
