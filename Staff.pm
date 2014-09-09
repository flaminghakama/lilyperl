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
            chords => shift,
            chordTransposeFrom => shift,
            chordTransposeTo => shift
        } ; 
    }
    my @lilypond ; 
    $self->{lilypond} = \@lilypond ; 
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
#  Expects input of music.
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

sub transposeMusic {
    my $self = shift ;
    my $music = shift ; 
    $music = ( $music ) ? $music : $self->music() ; 
    return $self->transpose( $music, $self->musicTransposeTo(), $self->musicTransposeFrom() ) ; 
}

sub reverseTransposeMusic {
    my $self = shift ;
    my $music = shift ; 
    $music = ( $music ) ? $music : $self->music() ; 
    return $self->transpose( $music, $self->musicTransposeFrom(), $self->musicTransposeTo() ) ; 
}

sub transposeChords {
    my $self = shift ;
    my $chords = shift ; 
    $chords = ( $chords ) ? $chords : $self->chords() ; 
    return $self->transpose( $chords, $self->chordsTransposeTo(), $self->chordsTransposeFrom() ) ; 
}

sub reverseTransposeChords {
    my $self = shift ;
    my $chords = shift ; 
    $chords = ( $chords ) ? $chords : $self->chords() ; 
    return $self->transpose( $chords, $self->chordsTransposeFrom(), $self->chordsTransposeTo() ) ; 
}

sub lilypond {
    my ( $self, $value ) = @_; 
    $self->{lilypond} = $value if defined $value ; 
    return $self->{lilypond};
}

sub lilypush {
    my ( $self, @lines ) = @_ ; 
    my (@lilypond) = $self->lilypond() ; 
    push( @lilypond, @lines ) ; 
    $self->{lilypond} = \@lilypond ;
    return $self->{lilypond} ; 
}

sub conditionalLily {
    my ( $self, $value, $before, $after ) = @_ ; 
    if ( $value ) { 
        my (@lilypond) = $self->lilypond() ; 
        push( @lilypond, $before . $value . $after ) ; 
        $self->{lilypond} = \@lilypond ;
    }
    return $self->{lilypond} ; 
}

sub render {
    my $self = shift ; 
    my $margin = shift ; 
    my $indent = $margin . '    ' ;
    my @lilypond = () ; 
    $self->{lilypond} = \@lilypond ; 
    $self->lilypush( $margin . '\new ChordNames '. $self->transposeChords() ) ; 
    $self->lilypush( $margin . '\new Staff {' ) ; 
    $self->conditionalLily( $self->instrumentName(), $indent . '\set Staff.instrumentName = #"', '"' ) ; 
    $self->conditionalLily( $self->shortInstrumentName(), $indent . '\set Staff.shortInstrumentName = #"', '"' ) ;
    $self->conditionalLily( $self->midiInstrument(), '\set Staff.midiInstrument = #"', '"' ) ; 
    $self->conditionalLily( $self->clef(), '\clef ' ) ;  
    $self->lilypush( 
        $indent . $self->transposeMusic(),
        $margin . '}' 
    ) ;

    return $self->lilypond() ; 
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
    $self->{lilypond} = \@lilypond ; 
    $self->lilypush( $margin . '\new ChordNames '. $self->transposeChords() ) ; 
    $self->lilypush( $margin . '\new DrumStaff <<' ) ; 
    $self->conditionalLily( $self->instrumentName(), $indent . '\set DrumStaff.instrumentName = #"', '"' ) ; 
    i$self->conditionalLily( $self->shortInstrumentName(), $indent . '\set DrumStaff.shortInstrumentName = #"', '"' ) ;
    $self->conditionalLily( $self->midiInstrument(), $indent . '\set DrumStaff.midiInstrument = #"', '"' ) ;
    $self->lilypush( 
        $indent . $self->music(),
        $margin . '>>'  
    ) ;

    return $self->lilypond() ; 
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
    my @lilypond = () ; 
    $self->{lilypond} = \@lilypond ; 
 
    $self->lilypush( $margin . '\new PianoStaff <<' ) ; 
    $self->conditionalLily( $self->instrumentName(), $indent . '\set PianoStaff.instrumentName = #"', '"' ) ; 
    $self->conditionalLily( $self->shortInstrumentName(), $indent . '\set PianoStaff.shortInstrumentName = #"', '"' ) ;
    $self->conditionalLily( $self->midiInstrument(), $indent . '\set PianoStaff.midiInstrument = #"', '"' ) ; 
    $self->lilypush( 
        $indent . '\new ChordNames \transpose ' . $self->chordTransposeTo . ' ' . $self->chordTransposeFrom . ' { ' . $self->chordSequence() . ' }',
        $indent . '\new Staff {' 
    ) ; 
    $self->conditionalLily( $self->clef(), $indent . '\clef ' ) ;
    $self->lilypush( 
        $indent . '    ' . $self->transpose( $self->music(), $self->musicTransposeTo(), $self->musicTransposeFrom() ),
        $indent . '}' 
    ) ;

    $self->conditionalLily( 
        $self->chordSequenceBelow(), 
        $indent . '\new ChordNames ' . $self->transpose( $self->chordSequenceBelow(), $self->chordTransposeToBelow(), $self->chordTransposeFromBelow() ) 
    ) ;
    $self->lilypush( $indent . '\new Staff {' ) ; 
    $self->conditionalLily( $self->clefBelow(), $indent . '    \clef ' ) ; 
    $self->lilypush( 
        $indent . '    ' . $self->transpose( $self->musicBelow(), $self->musicTransposeToBelow(), $self->musicTransposeFromBelow() ),
        $indent . '}',
        $margin . '>>' 
    ) ;

    return $self->{lilypond} ; 
}

1 ;
