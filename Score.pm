package Score ;
use staffGroup ;  
use Layout ; 
use parent 'Clone';

sub new {
    my $class = shift;
    my $self = shift ; 
    my @constructorFunction ;   
    unless ( ref($self) eq 'HASH' ) { 
        $self = {
            name => $self,
            sections => shift,
            header => shift,
            startingBarNumber => shift,
            barNumberVisibility => shift,
            doubleRepeatType => shift,
            staffGroups => shift,
            layout => shift,
            constructorFunction => shift,
            instruments => shift ; 
        } ; 
    }
    unless ( $self->{constructorFunction} ) { 
        $self->{constructorFunction} = \@constructorFunction ; 
    }
    return bless $self, $class;
}

sub name {
    my ( $self, $value ) = @_; 
    $self->{name} = $value if defined $value ; 
    return $self->{name};
}

sub sections {
    my ( $self, $value ) = @_; 
    $self->{sections} = $value if defined $value ; 
    return $self->{sections};
}

sub header {
    my ( $self, $value ) = @_; 
    $self->{header} = $value if defined $value ; 
    return $self->{header};
}

sub startingBarNumber {
    my ( $self, $value ) = @_; 
    $self->{startingBarNumber} = $value if defined $value ; 
    return $self->{startingBarNumber};
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

sub listSectionNames {
    my $self = shift ;
    my $section ; 
    my (@sections) = $self->sections() ; 
    my @sectionNames = () ; 
    foreach $section (@sections) {
        push( @sectionNames, $section->name() ) ;
    }
    return @sectionNames ; 
}

sub howManyMeasures {
    my $self = shift ;
    my $section ; 
    my (@sections) = $self->sections() ; 
    my $howManyMeasures = 0 ;
    foreach $section (@sections) {
        $howManyMeasures += $section->howManyMeasures() ; 
    }
    return $howManyMeasures ; 
}

#
#  To replace the array, supply a reference to an array.
#  To add to the array, supply a list of lines
#  Returns the reference to the constructorFunction array
#
sub constructorFunction {
    my ( $self, $value, @lines ) = @_; 
    if ( ref($value) eq 'ARRAY' ) {
        $self->{constructorFunction} = $value  ; 
    } else {
        my (@constructorFunction) = $self->{constructorFunction} ;
        if ( $value ) { push( @constructorFunction, $value ) ; } 
        if ( @lines ) { push( @constructorFunction, @lines ) ; } 
        $self->{constructorFunction} = \@constructorFunction ; 
    }
    return $self->{constructorFunction};
}

sub conditionalPush {
    my ( $self, $arrayRef, $value, $commandBegin, $commandEnd ) = @_ ; 
    my (@lilypond) = $arrayRef ; 
    if ( $value ) {
        push( @lilypond, $commandBegin . $value . $commandEnd) ; }
    }
    return \@lilypond ; 
}

#
#  Conditionally add a line to constructorFunction, based on the first argument.
#  Even though the value argument is first, the line is formatted:   commandBegin value commandEnd
#  @param {String} value The value used to test whether or not to add a line, as well as the value in the middle of the line
#  @param {String} commandBegin The string to place at the beginning of the line 
#  @param {String} commandEnd The string to place at the end of the line  
#
sub pushConstructorIf {
    my ( $self, $value, $commandBegin, $commandEnd ) = @_ ; 
    my (@constructorFunction) = $self->constructorFunction() ; 
    $self->constructorFunction( $self->conditionalPush( \@constructorFunction, $value, $commandBegin, $commandEnd ) ) ; 
}

#
#  Takes a list of lines to be added at the end of each section.
#  Produces a scheme function with the score sections as arguments 
#
sub createConstructorFunction {

    my ( $self, @barlines ) = shift ; 

    my $indent = '    ' ;
    my (@sectionNames) = $self->listSectionNames() ; 
    my $argumentTypeList = " ly:music?" x @sectionNames ; 

    $self->constructorFunction( 
        'rehearsalMarks' . $self->name() . ' = #(define-music-function', 
        $indent . '(parser location   ' . join( " ", @sectionNames ) . ' )',
        $indent . '                 ( ' . $argumentTypeList . ' )',    
        $indent . '#{'
    ) ;  

    $self->pushConstructorIf( $indent . '\compressFullBarRests' ) ;
    $self->pushConstructorIf( $indent . "\\override MultiMeasureRest #'expand-limit = #2" ) ;
    $self->pushConstructorIf( $indent . "\\override Staff.TimeSignature   #'style = #'numbered" ) ; 

    my (@sections) = $self->sections() ;
    my $section ;
    foreach $section (@sections) {
        $self->pushConstructorIf( $section->key(), $indent . '\key ' )
        $self->pushConstructorIf( $section->tempo(), $indent . '\tempo ' ) ; 
        $self->pushConstructorIf( $section->timeSignature(), $indent . '\time ' ) ; 
        $self->pushConstructorIf( $section->rehearsal(), $indent . '\mark \markup { \box ',  ' }' ) ; 
        $self->constructorFunction( $indent . '$' . $section->name() ) ;  
        foreach ( @barlines ) {
            $self->pushConstructorIf( $indent . $_ ) ; 
        }
    }
    $self->constructorFunction( '#})' ) ; 

    return $self->{constructorFunction} ; 
}

#
#  Create music definitions and rehearsal marks invocations for the specified staff group 
#  (or if none is specified, for all staff groups).
#      Music definitions for each Instrument-Score-Section with default music content
#      Rehearsal marks function invocations for each Instrument - Score 
#
sub createMusicDefinitions {
    my $self = shift ; 
    my $staffGroupName = shift ; 
    my $indent = '    ' ;
    my @staffGroups = ( $staffGroupName ) ? ( $self->staffGroups ) $self->staffGroups() ; 
    my @instruments ; 
    my $instrument ; 
    my @functionInvocations ;
    my $section ; 
    my (@sections) = $self->sections() ;
    my $sectionName ; 
    my @musicDefinitions ;
    foreach $staffGroup (@staffGroups) {
     
        unless ( $staffGroupName && ($staffGroupName neq $staffGroup->name()) ) { 

            (@instruments) = $staffGroup->instruments() ; 
            foreach $instrument (@instruments) {

                push( @functionInvocations, $instrument->name() . $self->name() . ' = \rehearsalMarks' . $self->name() ) ;

                foreach $section (@sections) {
                    $sectionName = $instrument->name() . $self->name() . $section->name() ;
                    push( @functionInvocations, $indent . '{ ' . $staff->reverseTransposeMusic( "\\$sectionName" ) . ' }' ) ;  
                    push( @musicDefinitions, 
                          $sectionName . " = \\relative c' {", 
                          $indent . $section->defaultMusic(), 
                         '}' 
                    ) ;
                }
            }
        }
    }
    return ( @musicDefinitions, @functionInvocations ) ;
}
                
#
#  Create chord sequence definitions for all sections 
#
sub createChordDefinitions {
    my $self = shift ; 
    my $indent = '    ' ;
    my $section ; 
    my (@sections) = $self->sections() ;
    my $sectionName ;
    my @chordDefinitions ;
    foreach $section (@sections) {
        $sectionName = $self->name() . $section->name() ;
        push( @chordsDefinitions, 
              $sectionName . "Chords = \\chordmode { \\set chordChanges = ##t \set chordNameExceptions = #chExceptions",
              $indent . $section->defaultChords(),
              '}'
        ) ; 
    }
    return ( @chordDefinitions ) ;
}
      
#
#  If a list of instruments is supplied, set self->{instruments} to that list.
#  If self->{instruments} is defined already, return that.
#  Otherwise (nothing supplied and not initialized), pull the instruments from the staff groups.
#
 sub instruments {
    my ( $self, @instruments ) = shift ; 
    if ( @instruments ) {
        $self->{instruments} = \@instruments ; 
    } else {
        unless ( defined $self->{instruments} ) {
            my $staffGroup ; 
            my (@staffGroups) = $self->staffGroups() ; 
            foreach $staffGroup (@staffGroups) {
                push( @instruments, $staffGroup->instruments() ) ; 
            }
        }
    }
    return @instruments ; 
}

#
#  Actually returns an array of instruments.
#  Because you may have multiple staves per instrument.
#
sub getInstrument { 
    my $self = shift ; 
    my $name = shift ;
    my $instrument ; 
    my @instruments = $self->instruments() ; 
    my @instrument ; 
    foreach $instrument (@instruments) {
        if ( $instrument->name() eq $name ) {
            push( @instrument, $instrument ) ; 
        }
    }
    return @instrument ; 
}

sub render {
    my $self = shift ; 
    my $margin = shift ; 
    my $indent = $margin . '    ' ;
    my $transposed = shift ; 

    my @lilypond ;
    $self->lilypond( \@lilypond ) ;  
    $self->lilypush( $self->header()->title(), "$margin%%%%%%% ", " %%%%%%%" ) ; 
    $self->lilypush( "$margin\\score <<" ) ; 

    $self->lilypush( $self->startingBarNumber(), "$indent\\set Score.currentBarNumber = #" ) ; 
    $self->lilypush( $self->barNumberVisibility(), "$indent\\override Score.BarNumber #'break-visibility = #'#(", ")" ) ; 
    $self->lilypush( $self->doubleRepeatType(), "$indent\\set Score.doubleRepeatType = #\"", '"' ) ; 

    my $staffGroup ; 
    my $staffGroupsRef = $self->staffGroups() ; 
    foreach $staffGroup (@$staffGroupsRef) {
        $self->lilypush( $staffGroup->render( $indent, $transposed ) ) ; 
    }
    $self->lilypush( "$margin>>" ) ; 

    if ( $self->header() ) { 
        $self->lilypond(
            "$margin\\header {", 
            $self->header()->render($margin), 
            "$margin}"                  
        ) ;  
    }
    $self->lilypond( $self->layout()->render($margin) ) ;
    return $self->lilypond() ; 
}

1 ;
