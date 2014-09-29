package Header ; 
sub new {
    my $class = shift;
    my $self = shift ; 
    my @lilypond ; 
    unless ( ref($self) eq 'HASH' ) { 
        $self = {
            piece => $self, 
            source => shift,    
            style => shift,    
            copyright => shift,    
            lastupdated => shift,    
            title => shift,  
            titleFontSize => shift,   
            poet => shift,    
            composer => shift,    
            arranger => shift,    
            tagline => shift, 
            lilypond => shift 
        } ;
    }
    unless ( $self->{lilyond} ) {
        $self->{lilypond} = \@lilypond ;  
    }
    return bless $self, $class;
}

sub piece {
    my ( $self, $value ) = @_; 
    $self->{piece} = $value if defined $value ; 
    return $self->{piece};
}

sub source {
    my ( $self, $value ) = @_; 
    $self->{source} = $value if defined $value ; 
    return $self->{source};
}

sub style {
    my ( $self, $value ) = @_; 
    $self->{style} = $value if defined $value ; 
    return $self->{style};
}

sub copyright {
    my ( $self, $value ) = @_; 
    $self->{copyright} = $value if defined $value ; 
    return $self->{copyright};
}

sub lastupdated {
    my ( $self, $value ) = @_; 
    $self->{lastupdated} = $value if defined $value ; 
    return $self->{lastupdated};
}

sub title {
    my ( $self, $value ) = @_; 
    $self->{title} = $value if defined $value ; 
    return $self->{title};
}

sub titleFontSize {
    my ( $self, $value ) = @_; 
    $self->{titleFontSize} = $value if defined $value ; 
    return $self->{titleFontSize};
}

sub poet {
    my ( $self, $value ) = @_; 
    $self->{poet} = $value if defined $value ; 
    return $self->{poet};
}

sub composer {
    my ( $self, $value ) = @_; 
    $self->{composer} = $value if defined $value ; 
    return $self->{composer};
}

sub arranger {
    my ( $self, $value ) = @_; 
    $self->{arranger} = $value if defined $value ; 
    return $self->{arranger};
}

sub tagline {
    my ( $self, $value ) = @_; 
    $self->{tagline} = $value if defined $value ; 
    return $self->{tagline};
}

sub lilypond {
    my ( $self, $value ) = @_; 
    $self->{lilypond} = $value if defined $value ; 
    return $self->{lilypond};
}

sub conditionalLily {
    my ( $self, $value, $before, $after ) = @_ ; 
    if ( $value ) { 
        my $lilypondRef = $self->lilypond() ; 
        my @lilypond = @$lilypondRef ; 
        push( @lilypond, $before . $value . $after ) ; 
        $self->{lilypond} = \@lilypond ;
    }
    return $self->{lilypond} ; 
}

sub render {
    my $self = shift ; 
    my $margin = shift ;
    my $indent = $margin . '    ' ; 
    $self->conditionalLily( $self->piece(), $indent . 'piece = "', '"') ;  
    $self->conditionalLily( $self->source(), $indent . 'source = "', '"') ;
    $self->conditionalLily( $self->style(), $indent . 'style = "', '"') ;
    $self->conditionalLily( $self->copyright(), $indent . 'copyright = "', '"') ;
    $self->conditionalLily( $self->lastupdated(), $indent . 'lastupdated = "', '"') ;
    $self->conditionalLily( $self->title(), $indent . 'title = "', '"') ;
    $self->conditionalLily( $self->titleFontSize(), $indent . 'titleFontSize = "', '"') ;
    $self->conditionalLily( $self->poet(), $indent . 'poet = "', '"') ;
    $self->conditionalLily( $self->composer(), $indent . 'composer = "', '"') ;
    $self->conditionalLily( $self->arranger(), $indent . 'arranger = "', '"') ;
    $self->conditionalLily( $self->tagline(), $indent . 'tagline = "', '"') ;
    return @{ $self->lilypond() };  
}
1 ;
