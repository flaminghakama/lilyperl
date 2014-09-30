package Instrument ; 
use parent 'Lilyperl' ;
use Staff ; 
use StaffGroup ; 

sub new {
    my $class = shift;
    my $self = shift ; 
    unless ( ref($self) eq 'HASH' ) { 
        $self = {
            name => $self,
            instrumentName => shift, 
            shortInstrumentName => shift,
            midiInstrument => shift,
            clef => shift,
            transposition => shift, 
            staff => shift,
            include => shift,
            StaffGroup => shift 
        } ; 
    }
    return bless $self, $class;
}

sub name {
    my ( $self, $value ) = @_; 
    $self->{name} = $value if defined $value ; 
    return $self->{name};
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
    my $musicSuffix = shift ; 
    my $transposed = shift ;
    my $musicName = $self->name() . $musicSuffix ; 
    my $staff = Staff->new({
        'instrumentName'      => $self->instrumentName(),
        'shortInstrumentName' => $self->shortInstrumentName(),
        'midiInstrument'      => $self->midiInstrument(),
        'clef'                => $self->clef(),
        'music'               => "\\" . $musicName 
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

sub staffGroup {
    my ( $self, $value ) = @_; 
    $self->{staffGroup} = $value if defined $value ; 
    return $self->{staffGroup};
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
