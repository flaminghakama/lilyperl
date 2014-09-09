package Staff ; 

sub new {
    my $class = shift;
    my $self = shift ; 
    unless ( ref($self) eq 'HASH' ) { 
        $self = {
            instrumentName => $self, 
            shortInstrumentName => shift,
            midiInstrument => shift,
            clef => shift,
            music => shift,
            musicTransposeFrom => shift,
            musicTransposeTo => shift,
            chordSequence => shift,
            chordTransposeFrom => shift,
            chordTransposeTo => shift
        } ; 
    }
    return bless $self, $class;
}

sub instrumentName {
    my ( $self, $value ) = @_; 
    $self->{instrumentName} = $value if defined $value ; 
    return $self->{instrumentName};
}

sub shortInstrumentName {
    my ( $self, $value ) = @_; 
    $self->{shortInstrumentName} = $value if defined $value ; 
    return $self->{shortInstrumentName};
}

sub midiInstrument {
    my ( $self, $value ) = @_; 
    $self->{midiInstrument} = $value if defined $value ; 
    return $self->{midiInstrument};
}

sub clef {
    my ( $self, $value ) = @_; 
    $self->{clef} = $value if defined $value ; 
    return $self->{clef};
}

sub music {
    my ( $self, $value ) = @_; 
    $self->{music} = $value if defined $value ; 
    return $self->{music};
}

sub musicTransposeFrom {
    my ( $self, $value ) = @_; 
    $self->{musicTransposeFrom} = $value if defined $value ; 
    return $self->{musicTransposeFrom};
}

sub musicTransposeTo {
    my ( $self, $value ) = @_; 
    $self->{musicTransposeTo} = $value if defined $value ; 
    return $self->{musicTransposeTo};
}

sub chordSequence {
    my ( $self, $value ) = @_; 
    $self->{chordSequence} = $value if defined $value ; 
    return $self->{chordSequence};
}

sub chordTransposeFrom {
    my ( $self, $value ) = @_; 
    $self->{chordTransposeFrom} = $value if defined $value ; 
    return $self->{chordTransposeFrom};
}

sub chordTransposeTo {
    my ( $self, $value ) = @_; 
    $self->{chordTransposeTo} = $value if defined $value ; 
    return $self->{chordTransposeTo};
}

#
#  Not an object method.  
#  Expects input of music, from and to.
#
sub transpose {
    my $self = shift ;
    my $music = shift ; 
    my $to = shift ; 
    my $from = shift ;
    if ( $from && $to )  { 
        return "\\transpose $to $from { $music }" ; 
    }
    return $music ; 
}

sub render {
    my $self = shift ; 
    my $margin = shift ; 
    my $indent = $margin . '    ' ;

    my @lilypond = () ; 
    if ( $self->chordSequence() ) { 
        push( @lilypond, 
              $margin . '\new ChordNames '. $self->transpose( $self->music(), $self->chordTransposeTo(), $self->chordTransposeFrom() ) ) ;  
    }
    push( @lilypond,  $margin . '\new Staff {' ) ; 
    if ( $self->instrumentName() ) { 
        push( @lilypond, 
              $indent . '\set Staff.instrumentName = #"' . $self->instrumentName() . '"' ) ; 
    }
    if ( $self->shortInstrumentName() ) { 
        push( @lilypond, 
              $indent . '\set Staff.shortInstrumentName = #"' . $self->shortInstrumentName() . '"' ) ;
    } 
    if ( $self->midiInstrument() ) { 
        push( @lilypond, 
              $indent . '\set Staff.midiInstrument = #"' . $self->midiInstrument() . '"' ) ; 
    } 
    if ( $self->clef() ) { 
        push( @lilypond, 
              $indent . '\clef ' . $self->clef() ) ;
    } 
    push ( @lilypond, 
        $indent . '\transpose ' . $self->musicTransposeTo . ' ' . $self->musicTransposeFrom . ' { ' . $self->music() . ' }',
        $margin . '}'
    ) ;

    return @lilypond ; 
}

package DrumStaff ; 
use Staff ;
use strict ;
our @ISA = qw(Staff);    

sub render {
    my $self = shift ; 
    my $margin = shift ; 
    my $indent = $margin . '    ' ;
    my @lilypond = () ; 

    if ( $self->chordSequence() ) { 
        push( @lilypond, 
              $indent . '\new ChordNames \transpose ' . $self->chordTransposeTo . ' ' . $self->chordTransposeFrom . ' { ' . $self->chordSequence() . ' }' ) ; 
    }
    push ( @lilypond,  $margin . '\new DrumStaff <<' ) ; 
    if ( $self->instrumentName() ) { 
        push( @lilypond, 
              $indent . '\set DrumStaff.instrumentName = #"' . $self->instrumentName() . '"' ) ; 
    }
    if ( $self->shortInstrumentName() ) { 
        push( @lilypond, 
              $indent . '\set DrumStaff.shortInstrumentName = #"' . $self->shortInstrumentName() . '"' ) ;
    } 
    if ( $self->midiInstrument() ) { 
        push( @lilypond, 
              $indent . '\set DrumStaff.midiInstrument = #"' . $self->midiInstrument() . '"' ) ; 
    } 
    push( @lilypond, 
          $indent . $self->music(),
          $margin . '>>'  ) ;

    return @lilypond ; 
}


package PianoStaff ;
use base qw(Staff);
sub new {

    my $class = shift;
    my $self = shift ; 
    unless ( ref($self) eq 'HASH' ) { 
        $self->SUPER::new( $self, shift, shift, shift, shift, shift, shift, shift, shift, shift );
        $self->{clefBelow} = shift ; 
        $self->{musicBelow} = shift;
        $self->{musicBelowTransposeFrom} = shift;
        $self->{musicBelowTransposeTo} = shift;
        $self->{chordsBelow} = shift,
        $self->{chordTransposeFromBelow} = shift,
        $self->{chordTransposeToBelow} => shift
    }
    bless $self, $class;
    return $self;
}

sub clefBelow {
    my ( $self, $value ) = @_; 
    $self->{clefBelow} = $value if defined $value ; 
    return $self->{clefBelow};
}

sub musicBelow {
    my ( $self, $value ) = @_; 
    $self->{musicBelow} = $value if defined $value ; 
    return $self->{musicBelow};
}

sub musicTransposeFromBelow {
    my ( $self, $value ) = @_; 
    $self->{musicTransposeFromBelow} = $value if defined $value ; 
    return $self->{musicTransposeFromBelow};
}

sub musicTransposeToBelow {
    my ( $self, $value ) = @_; 
    $self->{musicTransposeToBelow} = $value if defined $value ; 
    return $self->{musicTransposeToBelow};
}

sub chordSequenceBelow {
    my ( $self, $value ) = @_; 
    $self->{chordSequenceBelow} = $value if defined $value ; 
    return $self->{chordSequenceBelow};
}

sub chordTransposeFromBelow {
    my ( $self, $value ) = @_; 
    $self->{chordTransposeFromBelow} = $value if defined $value ; 
    return $self->{chordTransposeFromBelow};
}

sub chordTransposeToBelow {
    my ( $self, $value ) = @_; 
    $self->{chordTransposeToBelow} = $value if defined $value ; 
    return $self->{chordTransposeToBelow};
}

sub render {
    my $self = shift ; 
    my $margin = shift ; 
    my $indent = $margin . '    ' ;
    my $instrumentName = ( defined $self->instrumentName() ) ? $self->instrumentName() : "" ; 
 
    my @lilypond = ( $margin . '\new PianoStaff <<' ) ; 
    if ( $self->instrumentName() ) { 
        push( @lilypond, 
              $indent . '\set PianoStaff.instrumentName = #"' . $self->instrumentName() . '"' ) ; 
    }
    if ( $self->shortInstrumentName() ) { 
        push( @lilypond, 
              $indent . '\set PianoStaff.shortInstrumentName = #"' . $self->shortInstrumentName() . '"' ) ;
    } 
    if ( $self->midiInstrument() ) { 
        push( @lilypond, 
              $indent . '\set PianoStaff.midiInstrument = #"' . $self->midiInstrument() . '"' ) ; 
    } 
    if ( $self->chordSequence() ) { 
        push( @lilypond, 
              $indent . '\new ChordNames \transpose ' . $self->chordTransposeTo . ' ' . $self->chordTransposeFrom . ' { ' . $self->chordSequence() . ' }' ) ; 
    }
    push( @lilypond, $indent . '\new Staff {' ) ; 
    if ( $self->clef() ) { 
        push( @lilypond, $indent . '\clef ' . $self->clef() ) ;
    } 
    push( @lilypond, 
          $indent . '    ' . $self->transpose( $self->music(), $self->musicTransposeTo(), $self->musicTransposeFrom() ),  
          $indent . '}'
    ) ;
    if ( $self->chordSequenceBelow() ) { 
        push( @lilypond, 
              $indent . '\new ChordNames ' . $self->transpose( $self->chordSequenceBelow(), $self->chordTransposeToBelow(), $self->chordTransposeFromBelow() ) ) ; 
    }
    push( @lilypond, $indent . '\new Staff {' ) ; 
    if ( $self->clefBelow() ) { 
        push( @lilypond, $indent . '    \clef ' . $self->clefBelow() ) ; 
    }
    push( @lilypond, 
          $indent . '    ' . $self->transpose( $self->musicBelow(), $self->musicTransposeToBelow(), $self->musicTransposeFromBelow() ),
          $indent . '}',
          $margin . '>>' 
    ) ;

    return @lilypond ; 
}

1 ;
