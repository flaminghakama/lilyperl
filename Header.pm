package Header ; 
sub new {
    my $class = shift;
    my $self = shift ; 

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
            tagline => shift
        } ;
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

sub render {
    my $self = shift ; 
    my $margin = shift ;
    my $indent = $margin . '    ' ; 
    my @lilypond = () ; 
    $self->lilypush( $self->piece(), $indent . 'piece = "', '"') ;  
    if ( $self->source() ) { push (@lilypond, $indent . 'source = "' . $self->source() . '"') ; }
    if ( $self->style() ) { push (@lilypond, $indent . 'style = "' . $self->style() . '"') ; }
    if ( $self->copyright() ) { push (@lilypond, $indent . 'copyright = "' . $self->copyright() . '"') ; }
    if ( $self->lastupdated() ) { push (@lilypond, $indent . 'lastupdated = "' . $self->lastupdated() . '"') ; }
    if ( $self->title() ) { push (@lilypond, $indent . 'title = "' . $self->title() . '"') ; }
    if ( $self->titleFontSize() ) { push (@lilypond, $indent . 'titleFontSize = "' . $self->titleFontSize() . '"') ; }
    if ( $self->poet() ) { push (@lilypond, $indent . 'poet = "' . $self->poet() . '"') ; }
    if ( $self->composer() ) { push (@lilypond, $indent . 'composer = "' . $self->composer() . '"') ; }
    if ( $self->arranger() ) { push (@lilypond, $indent . 'arranger = "' . $self->arranger() . '"') ; }
    if ( $self->tagline() ) { push (@lilypond, $indent . 'tagline = "' . $self->tagline() . '"') ; }
    return @lilypond ;  
}
1 ;
