package Layout ; 
use Context ; 

sub new {
    my $class = shift;
    my $self = shift ; 
    unless ( ref($self) eq 'HASH' ) { 
        $self = {
            indent => $self,
            shortIndent => shift,
            chordFontSize => shift,
            raggedRight => shift,
            raggedLast => shift,
            removeEmptyStaff => shift
        } ; 
    }
    return bless $self, $class;
}

sub indent {
    my ( $self, $value ) = @_; 
    $self->{indent} = $value if defined $value ; 
    return $self->{indent};
}

sub shortIndent {
    my ( $self, $value ) = @_; 
    $self->{shortIndent} = $value if defined $value ; 
    return $self->{shortIndent};
}

sub chordFontSize {
    my ( $self, $value ) = @_; 
    $self->{chordFontSize} = $value if defined $value ; 
    return $self->{chordFontSize};
}

sub raggedRight {
    my ( $self, $value ) = @_; 
    $self->{raggedRight} = $value if defined $value ; 
    return $self->{raggedRight};
}

sub raggedLast {
    my ( $self, $value ) = @_; 
    $self->{raggedLast} = $value if defined $value ; 
    return $self->{raggedLast};
}

sub removeEmptyStaff {
    my ( $self, $value ) = @_; 
    $self->{removeEmptyStaff} = $value if defined $value ; 
    return $self->{removeEmptyStaff};
}

sub render {
    my $self = shift ; 
    my $margin = shift ; 
    my $indent = $margin . '    ' ; 
    my $raggedRight = ( $self->raggedRight() ) ? '##t' : '##f' ; 

    my @lilypond = ( $margin . '\layout {' ) ; 
    if ( $self->indent() ) { push( @lilypond, $indent. 'indent = ' . $self->indent() ) ; }
    if ( $self->shortIndent() ) { push( @lilypond, $indent. 'short-indent = ' . $self->shortIndent() ) ; }
    if ( $self->raggedRight() ) { push( @lilypond, $indent . 'ragged-right = ' . $raggedRight ) ; } 
    if ( $self->chordFontSize() ) { 
        push( @lilypond, 
              $indent . '\context {', 
              $indent . '    \ChordNames',
              $indent . "    \\override ChordName #'font-size = #" . $self->chordFontSize(),
              $indent . '}',
              ) ; 
    }
    if ( $self->removeEmptyStaff() ) { 
        push( @lilypond,  $indent . '\context { \removeEmptyStaffContext }' ) ; 
    }
    push( @lilypond, $margin . '}' ) ;
    return @lilypond ; 
}
1 ;
