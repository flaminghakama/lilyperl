package Score ; 

sub new {
    my $class = shift;
    my $self = shift ; 
    unless ( ref($self) eq 'HASH' ) { 
        $self = {
            header => $self,
            currentBarNumber => shift,
            barNumberVisibility => shift,
            doubleRepeatType => shift,
            staffGroups => shift,
            layout => shift
        } ; 
    }
    return bless $self, $class;
}

sub context {
    my ( $self, $value ) = @_; 
    $self->{context} = $value if defined $value ; 
    return $self->{context};
}

sub header {
    my ( $self, $value ) = @_; 
    $self->{header} = $value if defined $value ; 
    return $self->{header};
}

sub currentBarNumber {
    my ( $self, $value ) = @_; 
    $self->{currentBarNumber} = $value if defined $value ; 
    return $self->{currentBarNumber};
}

sub barNumberVisibility {
    my ( $self, $value ) = @_; 
    $self->{barNumberVisibility} = $value if defined $value ; 
    return $self->{barNumberVisibility};
}

sub doubleRepeatType {
    my ( $self, $value ) = @_; 
    $self->{doubleRepeatType} = $value if defined $value ; 
    return $self->{doubleRepeatType};
}

sub staffGroups {
    my ( $self, $value ) = @_; 
    $self->{staffGroups} = $value if defined $value ; 
    return $self->{staffGroups};
}

sub layout {
    my ( $self, $value ) = @_; 
    $self->{layout} = $value if defined $value ; 
    return $self->{layout};
}

sub render {
    my $self = shift ; 
    my $margin = shift ; 
    my @lilypond = ('') ; 
    if ( $self->header() ) { 
        if ( $self->header()->title() ) { push( @lilypond, "$margin%%%%%%% " . $self->header()->title() . " %%%%%%%" ) ; }
    }
    push( @lilypond, "$margin\\score <<" ) ; 

    my $indent = $margin . '    ' ;
    if ( $self->currentBarNumber() ) { push( @lilypond, "$indent\\set Score.currentBarNumber = #" . $self->currentBarNumber() ) ; }
    if ( $self->barNumberVisibility() ) { push( @lilypond, "$indent\\override Score.BarNumber #'break-visibility = #'#(" . $self->barNumberVisibility() . ")" ) ; }
    if ( $self->doubleRepeatType() ) { push( @lilypond, "$indent\\set Score.doubleRepeatType = #\"" . $self->doubleRepeatType() . '"' ) ; } 

    my $staffGroup ; 
    my $staffGroupsRef = $self->staffGroups() ; 
    foreach $staffGroup (@$staffGroupsRef) {
        push(@lilypond, $staffGroup->render($indent)) ; 
    }
    push( @lilypond, "$margin>>" ) ; 

    if ( $self->header() ) { 
        push( @lilypond,
              "$margin\\header {", 
              $self->header()->render($margin), 
              "$margin}"                  ) ;  
    }
    if ( $self->layout() ) { push( @lilypond, $self->layout()->render($margin) ) ; }
    return @lilypond ; 
}

1 ;
