package Instrument ; 
use Staff ; 
use StaffGroup ; 

sub new {
    my $class = shift;
    my $self = shift ; 
    unless ( ref($self) eq 'HASH' ) { 
        $self = {
            name = $self,
            instrumentName => shift, 
            shortInstrumentName => shift,
            midiInstrument => shift,
            clef => shift,
            transposition => shift, 
            staff => shift,
            include => shift  
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

sub transposition {
    my ( $self, $value ) = @_; 
    $self->{transposition} = $value if defined $value ; 
    return $self->{transposition};
}

sub staff {
    my ( $self, $value ) = @_; 
    $self->{staff} = $value if defined $value ; 
    return $self->{staff};
}

sub createStaff {
    my $self = shift ; 
    my $transposed = shift ; 
    my $staff = Staff->new({
        'instrumentName'      => $self->instrumentName(),
        'shortInstrumentName' => $self->shortInstrumentName(),
        'midiInstrument'      => $self->midiInstrument(),
        'clef'                => $self->clef(),
        'music'               => "\\" . $self->name()
    }) ; 
    if ( $transposed && $self->transposition() ) {
        $staff->musicTransposeFrom( 'c' ) ; 
        $staff->musicTransposeTo( $self->transposition() ) ; 
    }
    return $staff ;
}

sub include {
    my ( $self, $value ) = @_; 
    $self->{include} = $value if defined $value ; 
    return $self->{include};
}

package DrumInstrument ; 
use Staff ;
use strict ;
our @ISA = qw(Instrument);    



package PianoInstrument ;
use base qw(Instrument);
sub new {

    my $class = shift;
    my $self = shift ; 
    unless ( ref($self) eq 'HASH' ) { 
        $self->SUPER::new( $self, shift, shift, shift, shift );
        $self->{clefBelow} = shift ; 
    }
    bless $self, $class;
    return $self;
}

sub clefBelow {
    my ( $self, $value ) = @_; 
    $self->{clefBelow} = $value if defined $value ; 
    return $self->{clefBelow};
}

1 ;
