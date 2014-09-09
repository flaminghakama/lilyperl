#!/usr/bin/perl   

use strict;
use warnings;
use constant { TRUE => 1, FALSE => 0 } ;

use Includes ; 

use Paper ; 
    use Page ; 
    use Space ; 
    use Pagination ; 
    use Fonts ; 

use Layout ; 

use Book ; 
    use ScoreDefaults ; 

use Staff ; 
use StaffGroup ; 
use Score ; 
use PartNames ; 
use Part ; 

sub say { 
    print join("\n", @_, '') ; 
}


### CHART ###

my $includes = Includes->new
    ( 'english.ly', 
      'chords.ly',
      'music/oboe.ly',
      'music/saxes.ly',
      'music/trumpets.ly',
      'music/horn.ly',
      'music/trombones.ly' ) ; 

### PAPER ###

my $page = Page->new
    ({ 'size'        => 'letter', 
       'orientation' => 'landscape' }) ; 

$page->definePageSize(
    "#(set! paper-alist (cons '(\"poster\" . (cons (* 11 in) (* 17 in))) paper-alist))"
    ) ; 

my $space = Space->new
    ({ 'afterHeaderFirstPage'      => '4',        
       'afterHeaderNextPage'       => '14',
       'betweenSystems'            => '18',
       'betweenTopOfPageAndHeader' => ''   }) ;  

my $pagination = Pagination->new
    ({ 'printPageNumberFirst' => FALSE, 
       'printPageNumberNext'  => TRUE,
       'titleSplitLeft'       => 'As It',
       'titleSplitRight'      => 'Was'    }) ; 

my $fonts = Fonts->new
    ({ 'main'      => 'Agatha',
       'secondary' => 'Highlander ITC TT',
       'chords'    => 'Papyrus'  }) ; 

my $paper = Paper->new
    ({ 'page'       => $page, 
       'space'      => $space,
       'pagination' => $pagination, 
       'fonts'      => $fonts       }) ;

my $layout = Layout->new
    ({ 'indent'            => '3\cm',
        'shortIndent'      => '.25\cm',
        'chordFontSize'    => '3',
        'raggedRight'      => FALSE,
        'raggedLast'       => TRUE,
        'removeEmptyStaff' => TRUE      }) ; 

my $scoreDefaults = ScoreDefaults->new
    ({ 'staffSize'           => '', 
       'barNumberVisibility' => '',
       'layout'              => ''  }) ; 

my $headerOne = Header->new 
    ({ 'piece'         => 'my piece',
       'source'        => ' some  oseoue ',
       'style'         => 'Afro-Cuban',
       'copyright'     => 'copyright 1991-2014 D. Elaine Alt',
       'lastupdated'   => 'today',
       'title'         => 'As It Is',
       'titleFontSize' => 4,
       'poet'          => '',
       'composer'      => 'D. Elaine Alt',
       'arranger'      => 'Elaine',
       'tagline'       => 'taggish'  }) ; 

my $headerTwo = Header->new 
    ({ 'piece'         => '',
       'source'        => '',
       'style'         => '',
       'copyright'     => 'copyright 1991-2014 D. Elaine Alt',
       'lastupdated'   => '',
       'title'         => 'Solos',
       'titleFontSize' => 4,
       'poet'          => '',
       'composer'      => 'D. Elaine Alt',
       'arranger'      => '',
       'tagline'       => ''  }) ; 

my $staffOne = Staff->new
    ({ 'instrumentName'      => 'Bassoon',  # inherits from Part
       'shortInstrumentName' => 'Bsn',  # inherits from Part
       'midiInstrument'      => 'bassoon',  # inherits from Part
       'clef'                => 'bass',
       'music'               => '\mysteryMusic',  # inherits from Part.variable
       'musicTransposeFrom'  => "c",
       'musicTransposeTo'    => "c,",
       'chordSequence'       => '\soloChords',
       'chordTransposeFrom'  => "c",
       'chordTransposeTo'    => "c"  }) ;

my $staffTwo = Staff->new
    ({ 'instrumentName'      => 'Trumpet in Bb',  # inherits from Part
       'shortInstrumentName' => 'Trp.',  # inherits from Part
       'midiInstrument'      => 'trumpet',  # inherits from Part
       'clef'                => 'trumpet',
       'music'               => '\trumpet',  # inherits from Part.variable
       'musicTransposeFrom'  => "c",
       'musicTransposeTo'    => "bf,",
       'chordSequence'       => '\trumpetChords',
       'chordTransposeFrom'  => "c",
       'chordTransposeTo'    => "bf"  }) ;

my $pianoStaff = PianoStaff->new
    ({ 'instrumentName'          => 'Piano',  # inherits from Part
       'shortInstrumentName'     => 'Pno.',  # inherits from Part
       'midiInstrument'          => 'piano',  # inherits from Part
       'clef'                    => 'trumpet',
       'music'                   => '\someMusic',  # inherits from Part.variable
       'musicTransposeFrom'      => "c",
       'musicTransposeTo'        => "bf,",
       'chordSequence'           => '\trumpetChords',
       'chordTransposeFrom'      => "c",
       'chordTransposeTo'        => "bf",
       'clefBelow'               => 'bass',
       'musicBelow'              => '\someLeftHandMusic',
       'musicBelowTransposeFrom' => 'c',
       'musicBelowTransposeTo'   => 'c',
       'chordSequenceBelow'      => '\trumpetChords',
       'chordTransposeFromBelow' => "c",
       'chordTransposeToBelow'   => "bf"   }) ; 

my @stavesOne = ( $staffOne, $pianoStaff ) ;

my @stavesTwo = ( $staffTwo ) ;

my $staffGroupOne = StaffGroup->new
     ({ 'name'                => "Woodwinds",
        'staves'              => \@stavesOne  }) ; 

my $staffGroupTwo = StaffGroup->new
     ({ 'name'                => "Brass",
        'staves'              => \@stavesTwo  }) ; 

my @staffGroups = ( $staffGroupOne, $staffGroupTwo ) ; 

my $scoreOne = Score->new 
    ({ 'header'              => $headerOne, 
       'currentBarNumber'    => 1,
       'barNumberVisibility' => '#f #f #f',
       'doubleRepeatType'    => ':..:',
       'staffGroups'         => \@staffGroups,
       'layout'              => $layout        }) ;

my $scoreTwo = Score->new 
    ({ 'header'              => $headerTwo, 
       'currentBarNumber'    => 1,
       'barNumberVisibility' => '#f #f #f',
       'doubleRepeatType'    => ':..:',
       'staffGroups'         => \@staffGroups,
       'layout'              => $layout        }) ;


my @scores = ( $scoreOne, $scoreTwo ) ;  

my $book = Book->new
    ({ 'paper'         => $paper,
       'header'        => $headerOne,  
       'scoreDefaults' => $scoreDefaults,
       'scores'        => \@scores         }) ;

#$book->addScore( $scoreOne ) ; 
#$book->addScore( $scoreTwo ) ; 

my $partNames = PartNames->new
    ({ 'variableName'    => 'oboe',
       'pdfSuffix'       => 'Concert', 
       'pdfPart'         => 'Oboe' }) ; 

my $part = Part->new
    ( '2.18.2',
      $includes, 
      $paper, 
      $partNames, 
      $book
    ) ; 

say $part->render ; 
