package Book ; 
use parent 'Lilyperl' ;
use Paper ; 
use Header ; 
use Score ; 
use MusicDefinitions ; 
use Includes ; 
use Scalar::Util 'blessed';
my $isa = sub {blessed $_[0] and $_[0]->isa($_[1])};
use parent 'Clone';

#
#   Allow two forms of constructor in terms of the scores parameter:
#       an array of scores
#       a single score 
#
sub new {
    my $class = shift;
    my $self = shift ; 
    my @scores ; 
    unless( ref($self) eq 'HASH' ) { 
        $self = {
            name => $self, 
            version => $self, 
            includes => shift, 
            page => shift, 
            header => shift,
            scores => shift,
            transposed => shift, 
            musicDefinitions => shift, 
            instruments => shift, 
            parts => shift 
        } ; 
    }
    if ( blessed $self->{scores} ) { 
        if ( $self->{scores}->isa('Staff') ) {
            @scores = ( $self->{scores} ) ; 
            $self->{scores} =  \@scores ; 
        }
    } 
    unless ( $self->{musicDefinitions} ) {
        $self->{musicDefinitions} = MusicDefinitions->new() ; 
    }
    return bless $self, $class;
}

sub name {
    my ( $self, $value ) = @_; 
    $self->{name} = $value if defined $value ; 
    return $self->{name};
}

sub version {
    my ( $self, $value ) = @_; 
    $self->{version} = $value if defined $value ; 
    return '\version "' . $self->{version} . '"';
}

sub includes {
    my ( $self, $value ) = @_; 
    $self->{includes} = $value if defined $value ; 
    return $self->{includes};
}

sub pushIncludes {
    my ( $self, @files ) = @_; 
    return $self->{includes} unless @files ; 
    return $self->includes()->pushFiles( @files ) ; 
}

sub page {
    my ( $self, $value ) = @_; 
    $self->{page} = $value if defined $value ; 
    return $self->{page};
}

sub header {
    my ( $self, $value ) = @_; 
    $self->{header} = $value if defined $value ; 
    return $self->{header};
}

sub scores {
    my ( $self, $value ) = @_; 
    $self->{scores} = $value if defined $value ;
    return $self->{scores};
}

sub getScores {
    my ( $self, @scoreNames ) = @_; 
    my $scoreName ; 
    my $scoresRef = $self->scores() ; 
    my @scores = @$scoresRef ; 
    my @selectedScores ; 
    foreach $scoreName ( @scoreNames ) {
        foreach $score ( @scores ) {
            if ( $score->name() eq $scoreName ) { 
                push( @selectedScores, $score ) ; 
            } 
        }
    }
    return @selectedScores;
}

sub pushScores {
    my ( $self, @newScores ) = shift ; 
    my $scoresRef = $self->scores() ; 
    my @scores = @$scoresRef ; 
    my $score ; 
    foreach $score ( @newScores ) {
        push( @scores, $score ) ; 
    } 
    $self->{scores} = \@scores ; 
    return $self->{scores};
}

sub transposed {
    my ( $self, $value ) = @_; 
    $self->{transposed} = $value if defined $value ; 
    return $self->{transposed};
}

#
#  @param {String} filename The file where the functions will be saved (does not create the file).
#  @param {Array} List of lilypond lines to include between each section of a score, which defaults to a double bar line.  
#  @returns {Array} Populaltes the musicDefinitions->()functions() property returns these function definitions.
#
sub createConstructorFunctions {

    my ( $self, $filename, @betweenSections ) = @_ ;
    $self->musicDefinitions()->functionsFilename( $filename ) ;
    $self->musicDefinitions()->functionsInclude( Includes->new($filename) ) ;
    (@betweenSections) = ( @betweenSections ) ? (@betweenSections) : ( '\bar "||"' ) ;

    my $score ;
    my $scoresRef = $self->scores() ; 
    my @scores = @$scoresRef ; 
    foreach $score (@scores) {
        $self->musicDefinitions()->pushFunction( $score->createConstructorFunction(@betweenSections) )
    }
    return $self->musicDefinitions()->functions() ; 
}

sub musicDefinitions {
    my ( $self, $value ) = shift ;
    $self->{musicDefinitions} = $value if defined $value ; 
    return $self->{musicDefinitions} ; 
}

#
#  Creates a file for each staff group
#  Files are located in specified directory, named by staff group name + .ly
#  Sets the musicDefinitions->staffGroupIncludes() to this set of files, and return this list ref.
#  Each file contain the book's lilypond version and global includes, plus the music and chord definitions for that staff group.
#
sub writeMusicDefinitionsFiles {

    my ( $self, $musicDir ) = @_ ; 

    my $staffGroup ; 
    my $staffGroupsRef = $self->getStaffGroups() ; 
    my @staffGroups = @$staffGroupsRef ; 
    my $staffGroupName ; 
    my $filename ; 
    my $fh ; 
    my $score ; 
    my $scoresRef = $self->scores() ; 
    my @scores = @$scoresRef ; 
    my @lilypond ; 
    foreach $staffGroup (@staffGroups) {
        $staffGroupName = $staffGroup->name() ; 
        $filename = 'music/' . $staffGroupName . '.ly' ; 
        open( $fh, '>', $filename ) or 
            die "Could not open music definitions file '$filename': " . $! ;  
        print "$filename\n" ; 
        (@lilypond) = ( 
            "%%%%% Music definitions for staff group $staffGroupName for " . $self->name() . " %%%%%", 
            $self->version(), 
            $self->includes()->render(), 
            $self->musicDefinitions()->functionsInclude()->render(),
            ''
        ) ;
        foreach $score (@scores) {
            push( @lilypond, $score->createMusicDefinitions($staffGroupName) ) ; 
            push( @lilypond, $score->createChordDefinitions($staffGroupName) ) ; 
        }
        print $fh join("\n", @lilypond) ; 
        close $fh ; 
        $self->musicDefinitions()->pushStaffGroupIncludes( "../$filename" ) ; 
    }
    return $self->musicDefinitions()->staffGroupIncludes() ; 
}

#
#  If a score name is specified, return the staff groups for that score.
#  Otherwise, return the staff groups for the first score.
#
sub getStaffGroups {
    my $self = shift ; 
    my $scoreName = shift ; 
    my $scoresRef = $self->scores() ; 
    my @scores = @$scoresRef ; 
    unless ( $scoreName ) {
        $scoreName = $scores[0]->name() ; 
    }
    my @theseScores = $self->getScores($scoreName) ; 
    my $thisScore = $theseScores[0] ; 
    return $thisScore->staffGroups() ; 
}

#
#   Not currently used, but possibly helpful.
#
sub sequenceMeasureNumbers {
    my $self = shift ; 
    my $score ; 
    my $scoresRef = $self->scores() ; 
    my @scores = $scoresRef ; 
    my $lastBarNumber = 0 ; 
    foreach $score (@scores) {
        $score->startingBarNumber( $lastBarNumber + 1 ) ;
        $lastBarNumber += $score->howManyMeasures() ; 
    }
    return $lastBarNumber ;
}

#
#  Returns a list of instruments.
#  If no score name is specified, returns the list of instruments from the first score in the book.
#  If a score name is specified, returns the list of instruments from the first score in the book with the specified score name.
#      If no score has the specified name, returns undef.
#
sub instruments {
    my $self = shift ; 
    my $scoreName = shift ; 
    my $score ; 
    my $scoresRef = $self->scores() ; 
    my @scores = @$scoresRef ; 
    foreach $score (@scores) {
        unless ( $scoreName ) { 
            return $score->instruments() ; 
        }
        if ( $scoreName eq $score->name() ) { 
            return $score->instruments() ; 
        }
    }
    return undef ; 
}

#
#  Returns an set of updated books with only one instrument per book.
#  If there are multiple staves with the same instrument name, all those are included in the same book.
#
sub parts { 
    my $self = shift ; 
    my (@instruments) = $self->instruments() ; 
    my @parts ;     
    foreach $instrument (@instruments) {
        push( @parts, $self->part( $instrument->name() ) ); 
    }
    return $self->parts( \@parts ) ;
}

#
#  Returns an version of the book without all instruments expect the specified instrument.
#  If there are multiple staves with the same instrument name, all those are included.
#
sub part {
    my $self = shift ; 
    my $instrumentName = shift ; 
    my $score ; 
    my $scoresRef = $self->scores() ; 
    my @scores = @$scoresRef ; 
    my $partScore ; 
    my $staffGroupsRef ; 
    my @staffGroups ;
    my $staffGroup ; 
    my $instrument ; 
    my @partScores ; 
    my $part = $self->clone() ; 
    foreach $score (@scores) {
        my $partScore = $score->clone() ;
        $staffGroupsRef = $partScore->staffGroups() ; 
        @staffGroups = @$staffGroupsRef ; 
        my @partStaffGroups ; 
        foreach $staffGroup (@staffGroups) {
            my @instruments ;
            my $partStaffGroup = $staffGroup->clone() ;
            $instrument = $partStaffGroup->instrument( $instrumentName ) ;
            if ( $instrument ) { 
                push( @instruments, $instrument ) ; 
            }
            if ( @instruments ) {
                $partStaffGroup->instruments( \@instruments ) ;
                push( @partStaffGroups, $partStaffGroup ) ;
            } 
        }
        $partScore->staffGroups( \@partStaffGroups ) ; 
        push( @partScores, $partScore ) ; 
    }
    $part->scores( \@partScores ) ; 
    return $part ; 
}

sub render {
    my $self = shift ; 
    my $margin = shift ; 
    my $indent = $margin . '    ' ; 
    my @lilypond = ( "book {" ) ; 

    if ( $self->page() ) {  
        push( @lilypond,
              $indent . '\paper {', 
              $self->page()->space()->render($indent),
              $indent . '}' ) ; 
    }

    if ( $self->header() ) {  
        push( @lilypond,
              $indent . '\header {', 
              $self->header()->render($indent), 
              "$indent}"                  ) ; 
    }

    my $score ; 
    my $scoresRef = $self->scores() ; 
    my @scores = @$scoresRef ; 
    foreach $score ( @scores ) {
        push( @lilypond, $score->render( $indent, $self->transposed() ) ) ;
    }

    push( @lilypond, '}' ) ; 

    return @lilypond ;
}

1 ; 
