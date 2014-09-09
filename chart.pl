#!/usr/bin/perl   

use strict;
use warnings;
use Roman;
use parent 'Clone';

use Book ;

my %book ; 

my $includes = Includes->new ( 
	'english.ly'
) ; 

my $header = Header->new ({  
    'style'         => 'Afro-Cuban',
    'copyright'     => 'copyright 1991-2014 D. Elaine Alt',
    'lastupdated'   => '`date`',
    'title'         => 'As It Is',
    'titleFontSize' => 4,
    'poet'          => '',
    'composer'      => 'D. Elaine Alt',
}) ; 


#
#  Define $partPaper and $scorePaper
#
use Page ; 
$page{'part'}->pagination()->titleSplitLeft('As It') ; 
$page{'part'}->pagination()->titleSplitRight('Is') ; 
$page{'score'}->pagination()->titleSplitLeft('As It') ; 
$page{'score'}->pagination()->titleSplitRight('Is') ; 

$page{'part'}->fonts()->main('Agatha') ; 
$page{'score'}->fonts()->main('Agatha') ; 


###################################
#    SCORES AND SCORE SECTIONS    #
###################################

my @scores ; 

#
#  Define @scoreNames and %sections
#
my @scoreNames = (
  'Intro', 
  'FirstSolo', 
  'HeadIn',
  'SecondSolo',
  'ThirdSolo', 
  'HeadOut'
);

my %sections ; 
my $sections{'Intro'} = ()
    Section->new({
        'name'            => 'Fanfare',
        'displayName'     => 'Fanfare',
        'key'             => 'e \minor',
        'tempo'           => '\tempo "Afro-Latin " 2=104',
        'timeSignature'   => "\\time 2/2" 
        'howManyMeasures' => 12,
        'defaultMusic'    => 'R1 * 12',
        'defaultChords'   => 'R1 * 12'
    }),
    Section->new({
        'name'            => 'Buildup',
        'displayName'     => 'Buildup',
        'howManyMeasures' => 16,
        'defaultMusic'    => 'R1 * 16',
        'defaultChords'   => 'e1:m e:m e:m e:m   e:m e:m e:m e:m   e:m e:m e:m e:m   e:m e:m e:m e:m'
    }) 
);

$sections{'FirstSolo'} = (
    Section->new({
        'name'            => 'ChorusI',
        'displayName'     => 'Solo',
        'howManyMeasures' => 16,
        'defaultMusic'    => 'R1 * 16',
        'defaultChords'   => 'e1:m e:m e:m e:m   e:m e:m e:m e:m   e:m e:m e:m e:m   e:m e:m e:m e:m'
    }),
    Section->new({
        'name       '     => 'ChorusII',
        'displayName'     => '(add Trb.)',
        'howManyMeasures' => 16,
        'defaultMusic'    => 'R1 * 16', 
        'defaultChords'   => 'e1:m e:m e:m e:m   e:m e:m e:m e:m   e:m e:m e:m e:m   e:m e:m e:m e:m'
    }),
    Section->new({
        'name'            => 'ChorusIII',
        'displayName'     => '(add Trp.)',
        'howManyMeasures' => 16,
        'defaultMusic'    => 'R1 * 16',
        'defaultChords'   => 'e1:m e:m e:m e:m   e:m e:m e:m e:m   e:m e:m e:m e:m   e:m e:m e:m e:m'
    }),
    Section->new({
        'name'            => 'ChorusIV',
        'displayName'     => '(add Sax)',
        'howManyMeasures' => 16,
        'defaultMusic'    => 'R1 * 16',
        'defaultChords'   => 'e1:m e:m e:m e:m   e:m e:m e:m e:m   e:m e:m e:m e:m   e:m e:m e:m e:m'
    }),
) ;

$sections{'HeadIn'} = (
    Section->new({
        'name'            => 'Fanfare',
        'displayName'     => 'Fanfare',
        'howManyMeasures' => 16,
        'defaultMusic'    => 'R1 * 16',
        'defaultChords'   => 'R1 * 16'
    }),
    Section->new({
        'name'            => 'HeadI',
        'displayName'     => 'Head',
        'howManyMeasures' => 16,
        'defaultMusic'    => 'R1 * 16',
        'defaultChords'   => 'e1:m e:m e:m e:m',
    }),
    Section->new({
        'name'            => 'HeadII',
        'displayName'     => '',
        'howManyMeasures' => 16,
        'defaultMusic'    => 'R1 * 16',
        'defaultChords'   => 'e1:m e:m e:m e:m',
    })
) ;  

$sections{'SecondSolo'} = (
    Section->new({
        'name'            => 'ChorusI',
        'displayName'     => 'Solo',
        'howManyMeasures' => 16,
        'defaultMusic'    => 'R1 * 16',
        'defaultChords'   => 'e1:m e:m e:m e:m',
    }),
    Section->new({
        'name'            => 'ChorusII',
        'displayName'     => '(add I)',
        'howManyMeasures' => 16,
        'defaultMusic'    => 'R1 * 16',
        'defaultChords'   => 'e1:m e:m e:m e:m',
    }),
    Section->new({
        'name'            => 'ChorusIII',
        'displayName'     => '(add II)',
        'howManyMeasures' => 16,
        'defaultMusic'    => 'R1 * 16',
        'defaultChords'   => 'e1:m e:m e:m e:m',
    }),
    Section->new({
        'name'            => 'ChorusIV',
        'displayName'     => '(add III)',
        'howManyMeasures' => 16,
        'defaultMusic'    => 'R1 * 16',
        'defaultChords'   => 'e1:m e:m e:m e:m',
    }),
    Section->new({
        'name'            => 'HeadIII',
        'displayName'     => 'Head',
        'howManyMeasures' => 16,
        'defaultMusic'    => 'R1 * 16',
        'defaultChords'   => 'e1:m e:m e:m e:m',
    }),
    Section->new({
        'name'            => 'HeadIV',
        'displayName'     => '',
        'howManyMeasures' => 16,
        'defaultMusic'    => 'R1 * 16',
        'defaultChords'   => 'e1:m e:m e:m e:m',
    })
) ;
  
$sections{'ThirdSolo'} = (
    Section->new({
        'name'            => 'ChorusI',
        'displayName'     => 'Solo',
        'howManyMeasures' => 16,
        'defaultMusic'    => 'R1 * 16',
        'defaultChords'   => 'e1:m e:m e:m e:m',
    }),
    Section->new({
        'name'            => 'ChorusII',
        'displayName'     => '(add I)',
        'howManyMeasures' => 16,
        'defaultMusic'    => 'R1 * 16',
        'defaultChords'   => 'e1:m e:m e:m e:m',
    }),
    Section->new({
        'name'            => 'ChorusIII',
        'displayName'     => '(add II)',
        'howManyMeasures' => 16,
        'defaultMusic'    => 'R1 * 16',
        'defaultChords'   => 'e1:m e:m e:m e:m',
    }),
    Section->new({
        'name'            => 'ChorusIV',
        'displayName'     => '(add III)',
        'howManyMeasures' => 16,
        'defaultMusic'    => 'R1 * 16',
        'defaultChords'   => 'e1:m e:m e:m e:m',
    }),
    Section->new({
        'name'            => 'ChorusIVEnding',
        'displayName'     => '',
        'howManyMeasures' => 1,
        'defaultMusic'    => 'R1 * 16',
        'defaultChords'   => 'e1:m e:m e:m e:m',
    })
) ;

$sections{'HeadOut'} = (
    Section->new({
        'name'            => 'LastEnding',
        'displayName'     => '',
        'howManyMeasures' => 16,
        'defaultMusic'    => 'R1 * 16',
        'defaultChords'   => 'e1:m e:m e:m e:m',
    }),
    Section->new({
        'name'            => 'Fanfare',
        'displayName'     => 'Fanfare',
        'howManyMeasures' => 16,
        'defaultMusic'    => 'R1 * 16',
        'defaultChords'   => 'e1:m e:m e:m e:m',
    }),
    Section->new({
        'name'            => 'HeadV',
        'displayName'     => 'Head',
        'howManyMeasures' => 16,
        'defaultMusic'    => 'R1 * 16',
        'defaultChords'   => 'e1:m e:m e:m e:m',
    }),
    Section->new({
        'name'            => 'HeadVI',
        'displayName'     => '',
        'howManyMeasures' => 16,
        'defaultMusic'    => 'R1 * 16',
        'defaultChords'   => 'e1:m e:m e:m e:m',
    }),
     Section->new({
        'name'            => 'Coda',
        'displayName'     => '',
        'howManyMeasures' => 16,
        'defaultMusic'    => 'R1 * 16',
        'defaultChords'   => 'e1:m e:m e:m e:m',
    })
) ;
 


#
#  Initialize Scores with Score Sections
#
#  Create rehearsal marks file 
#      For each score
#          Create function definition with score sections as parameters
#
my @scoreSections ; 
my @functions ; 
my $lastBarNumber = 0 ; 
foreach $scoreName (@scoreNames) {

    (@scoreSections) = $scoreSections{$scoreName} ; 

    my $score = Score->new({
       'name'                 => $scoreName,
       'sections'             => \@scoreSections,
    }) ;
    $score->startingBarNumber( $lastBarNumber + 1 ) ;
    push( @scores, $score ) ; 
    push( @functions, $score->createRehearsalMarksFunction( '\bar "||"' ) ) ; 
    $lastBarNumber += $score->howManyMeasures() ; 
}


##################### 
#    INSTRUMENTS    #
#####################

#
#  Define @instrumentSections and %instrument
#
my @instrumentSections = (
	'Woodwinds',
	'Saxophones',
	'Trumpets',
	'Horns',
	'Trombones',
	'Rhythm'
) ;

my %instrument ;

$instrument{'oboe'} = Instrument->new ({
    'name'                => 'oboe',
    'instrumentName'      => 'Oboe',
    'shortInstrumentName' => 'Oboe',
    'midiInstrument'      => 'oboe',
    'clef'                => 'treble',
    'transposition'       => 'c'
}) ;
$instrumentSection{'Woodwinds'} = ( 
	$instrument{'oboe'} 
) ;

$instrument{'altoI'} = Instrument->new ({
    'name'                => 'altoI',
    'instrumentName'      => 'Eb Alto Saxophone I',
    'shortInstrumentName' => 'Alto I',
    'midiInstrument'      => 'alto saxopohone',
    'clef'                => 'treble',
    'transposition'       => 'ef'
}) ;
$instrument{'altoII'} = Instrument->new ({
    'name'                => 'altoII',
    'instrumentName'      => 'Eb Alto Saxophone II',
    'shortInstrumentName' => 'Alto II',
    'midiInstrument'      => 'alto saxopohone',
    'clef'                => 'treble',
    'transposition'       => 'ef'
}) ;
$instrument{'tenorI'} = Instrument->new ({
    'name'                => 'tenorI',
    'instrumentName'      => 'Bb tenor Saxophone I',
    'shortInstrumentName' => 'Tenor I',
    'midiInstrument'      => 'tenor saxopohone',
    'clef'                => 'treble',
    'transposition'       => 'bf'
}) ;
$instrument{'tenorII'} = Instrument->new ({
    'name'                => 'tenorII',
    'instrumentName'      => 'Bb tenor Saxophone II',
    'shortInstrumentName' => 'Tenor II',
    'midiInstrument'      => 'tenor saxopohone',
    'clef'                => 'treble',
    'transposition'       => 'bf'
}) ;
$instrument{'bari'} = Instrument->new ({
    'name'                => 'bari',
    'instrumentName'      => 'Bb Baritone Saxophone',
    'shortInstrumentName' => 'Bari',
    'midiInstrument'      => 'baritone saxophone',
    'clef'                => 'treble',
    'transposition'       => 'ef'
}) ;
$instrumentSection{'Saxophones'} = ( 
	$instrument{'altoI'}, 
	$instrument{'altoII'}, 
	$instrument{'tenorI'}, 
	$instrument{'tenorII'}, 
	$instrument{'bari'} 
) ;

$instrument{'trumpetI'} = Instrument->new ({
    'name'                => 'trumpetI',
    'instrumentName'      => 'Bb Trumpet I',
    'shortInstrumentName' => 'Trp. I',
    'midiInstrument'      => 'trumpet',
    'clef'                => 'treble',
    'transposition'       => 'bf'
}) ;
$instrument{'trumpetII'} = Instrument->new ({
    'name'                => 'trumpetII',
    'instrumentName'      => 'Bb Trumpet II',
    'shortInstrumentName' => 'Trp. II',
    'midiInstrument'      => 'trumpet',
    'clef'                => 'treble',
    'transposition'       => 'bf'
}) ;
$instrument{'trumpetIII'} = Instrument->new ({
    'name'                => 'trumpetIII',
    'instrumentName'      => 'Bb Trumpet III',
    'shortInstrumentName' => 'Trp. III',
    'midiInstrument'      => 'trumpet',
    'clef'                => 'treble',
    'transposition'       => 'bf'
}) ;
$instrument{'trumpetIV'} = Instrument->new ({
    'name'                => 'trumpetIV',
    'instrumentName'      => 'Bb Trumpet IV',
    'shortInstrumentName' => 'Trp. IV',
    'midiInstrument'      => 'trumpet',
    'clef'                => 'treble',
    'transposition'       => 'bf'
}) ;
$instrumentSection{'Trumpets'} = ( 
	$instrument{'trumpetI'}, 
	$instrument{'trumpetII'}, 
	$instrument{'trumpetIII'}, 
	$instrument{'trumpetIV'}
) ;

$instrument{'horn'} = Instrument->new ({
    'name'                => 'horn',
    'instrumentName'      => 'F Horn',
    'shortInstrumentName' => 'Hrn.',
    'midiInstrument'      => 'french horn',
    'clef'                => 'treble',
    'transposition'       => 'f'
}) ;
$instrumentSection{'Horns'} = ( 
	$instrument{'horn'}
) ;

$instrument{'tromboneI'} = Instrument->new ({
    'name'                => 'tromboneI',
    'instrumentName'      => 'Trombone I',
    'shortInstrumentName' => 'Trb. I',
    'midiInstrument'      => 'trombone',
    'clef'                => 'treble',
    'transposition'       => 'c'
}) ;
$instrument{'tromboneII'} = Instrument->new ({
    'name'                => 'tromboneII',
    'instrumentName'      => 'Trombone II',
    'shortInstrumentName' => 'Trb. II',
    'midiInstrument'      => 'trombone',
    'clef'                => 'treble',
    'transposition'       => 'c'
}) ;
$instrument{'tromboneIII'} = Instrument->new ({
    'name'                => 'tromboneIII',
    'instrumentName'      => 'Trombone III',
    'shortInstrumentName' => 'Trb. III',
    'midiInstrument'      => 'trombone',
    'clef'                => 'treble',
    'transposition'       => 'c'
}) ;
$instrument{'tromboneIV'} = Instrument->new ({
    'name'                => 'tromboneIV',
    'instrumentName'      => 'Trombone IV',
    'shortInstrumentName' => 'Trb. IV',
    'midiInstrument'      => 'trombone',
    'clef'                => 'treble',
    'transposition'       => 'c'
}) ;
$instrumentSection{'Trombones'} = ( 
	$instrument{'tromboneI'}, 
	$instrument{'tromboneII'}, 
	$instrument{'tromboneIII'}, 
	$instrument{'tromboneIV'}
) ;

$instrument{'drums'} = DrumInstrument->new ({
    'name'                => 'drums',
    'instrumentName'      => 'Drums',
    'shortInstrumentName' => 'Drums',
    'midiInstrument'      => 'drums'
}) ;
$instrument{'piano'} = PianoInstrument->new ({
    'name'                => 'piano',
    'instrumentName'      => 'Piano',
    'shortInstrumentName' => 'piano',
    'midiInstrument'      => 'piano',
    'clef'                => 'treble',
    'transposition'       => 'c',
    'clefBelow'           => 'bass'
}) ;
$instrument{'guitar'} = Instrument->new ({
    'name'                => 'guitar',
    'instrumentName'      => 'Guitar',
    'shortInstrumentName' => 'Gtr.',
    'midiInstrument'      => 'guitar',
    'clef'                => 'treble',
    'transposition'       => 'c'
}) ;
$instrument{'bass'} = Instrument->new ({
    'name'                => 'bass',
    'instrumentName'      => 'Bass',
    'shortInstrumentName' => 'Bass',
    'midiInstrument'      => 'bass',
    'clef'                => 'bass',
    'transposition'       => 'c'
}) ;
$instrumentSection{'Rhythm'} = ( 
	$instrument{'drums'}, 
	$instrument{'piano'}, 
	$instrument{'guitar'}, 
	$instrument{'bass'}
) ;


#
#  Add instrument sections (staff groups) to scores
#
my $score
my $instrumentSectionName ; 
my @instruments ; 
my @staffGroups ; 
foreach $score (@scores) {

    foreach $instrumentSectionName (@instrumentSections) {

        (@instruments) = $instrumentSection{$instrumentSectionName} ; 
        
        my $staffGroup = StaffGroup->new({
           'name'        => $instrumentSectionName,
           'instruments' => \@instruments,
        }) ;
        push( @staffGroups, $staffGroup ) ; 
    }
}


#########################
#    Create the book    #
#########################

my $bookName = 'As It Is' ; 
$book{'master'} = Book->new({ 
    'name'       => $bookName,
    'version'    => '2.18.2',
    'includes'   => $includes,
	'paper'      => $paper,
    'header'     => $header,  
    'scores'     => \@scores, 
    'transposed' => 'Transposed'       
}) ;

#
#  Create a rehearsal marks function file
#
my %fh ; 
my %filename ; 
my %includes ; 
$filename{'rehearsalMarks'} = 'rehearsal-marks.ly' ; 
open( $fh{'rehearsalMarks'}, '>', $filename{'rehearsalMarks'} ) or 
  die "Could not open rehearsal marks file '" . $filename{'rehearsalMarks'} . "': " . $! ; 
print( $fh{'rehearsalMarks'}, $book{'full score'}->createConstructorFunctions( $filename{'rehearsalMarks'} ) ) ; 

my @includes = ( 'english.ly' ); 
my %includes ;
$includes{'global'} = ( \@includes ) ;

#
#  Create music definition files for each InstrumentSection ( StaffGroup )
#      adds to staffGroupIncludes the rehearsal marks file 
#      music definition for instrument-score-section with defaultMusic
#      chords definition for instrument-score-section with defaultChords
#      rehearsal marks invocation for instrument-score 
#
my $musicDir = 'music' ; 
$book->writeMusicDefinitionsFiles( $musicDir ) ; 

#
#  For each score,
#      Create chart for score - transposed
#      Create chart for condensed score - concert  
#
my $score ; 
my (@scores) = $book->{'master'}->scores() ; 
my $visiblePartName ;
my %chartNames ; 
my %chart ; 
my $scoreNumber = 0 ; 
my $scoreNumeral; 
my $lastNumber = 0 + @scores ; 

foreach $score (@scores) {

    $scoreName = $score->name() ; 
    ++$scoreNumber ;
    $scoreNumeral = Roman($scoreNumber);

    for $suffix in ( 'Transposed', 'Concert' ) { 

        $filename = 'scores/' . $score->name() . '-$suffix.ly' ; 
        open( $fh, '>', $filename ) or 
            die "Could not open score file '$filename': " . $! ;  

        $visiblePartName = "Score - $scoreNumeral of $lastNumber: $scoreName ($suffix)" ; 

        $chartNames{$visiblePartName} = ChartNames->new ({ 
            'chartName'       => $scoreName,     
            'visiblePartName' => $visiblePartName 
        }) ; 

        my $book{$visiblePartName} = Book->new ({
            'name'       => $bookName . $score->name(), 
            'scores'     => $score,
            'transposed' => $suffix eq 'Transposed' 
        }) ;

        $chart{$visiblePartName} = Chart->new ({
            'version'  => '2.18.2',
            'includes' => $includes,
            'page'     => $page{'score'}, 
            'names'    => $chartNames{$visiblePartName}, 
            'book'     => $book{$visiblePartName}
        ) ; 

        print( $fh, $chart{$scoreName}->render() ) ; 
        close( $fh ) ; 
    }
}

#
#      Create chart for full score - transposed
#
$filename = 'scores/Transposed.ly' ; 
open( $fh, '>', $filename ) or 
    die "Could not open score file '$filename': " . $! ;  

$visiblePartName = "Score (Transposed)" ; 

$chartNames{$visiblePartName} = ChartNames->new ({ 
    'chartName'   => $visiblePartName,     
    'pdfFileSuffix'   => '', 
    'visiblePartName'     => $visiblePartName 
}) ; 

$chart{$visiblePartName} = Chart->new ({
    'version'  => '2.18.2',
    'includes' => $includes,
    'page'     => $page{'score'}, 
    'names'    => $chartNames{$visiblePartName}, 
    'book'     => $book{'master'}
}) ;

print( $fh, $chart{$scoreName}->render() ) ; 
close( $fh ) ; 

#
#      Create chart for full score - concert
#
$filename = 'scores/Concert.ly' ; 
open( $fh, '>', $filename ) or 
    die "Could not open score file '$filename': " . $! ;  

$visiblePartName = "Score (Concert)" ; 

$chartNames{$visiblePartName} = ChartNames->new ({ 
    'chartName'   => $visiblePartName,
    'pdfFileSuffix'   => '', 
    'visiblePartName'     => $visiblePartName 
}) ; 

$book{$visiblePartName} = $book{'master'}->clone() ; 
$book{$visiblePartName}->transposed( 0 ) ; 

$chart{$visiblePartName} = Chart->new ({
    'includes' => $includes,
    'page'     => $page{'score'}, 
    'names'    => $chartNames{$visiblePartName}, 
    'book'     => $book{$visiblePartName}
}) ;

print( $fh, $chart{$scoreName}->render() ) ; 
close( $fh ) ; 

#
#      For each instrument, 
#          Create chart for part - transposed
#
my $instrument ; 
my @instruments = $book{'master'}->instruments() ;
foreach $instrument (@instruments) {

    $instrumentName = $instrument->name() ; 
    $filename = 'parts/' . $instrumentName . '.ly' ; 

    open( $fh, '>', $filename ) or 
        die "Could not open score file '$filename': " . $! ;  

    $visiblePartName = $instrumentName ;  ; 

    $chartNames{$visiblePartName} = ChartNames->new ({ 
        'chartName'       => $visiblePartName,
        'pdfFileSuffix'   => 'Transposed', 
        'visiblePartName' => $visiblePartName 
    }) ; 

    my $book = $book{'master'} ; 

    $chart{$visiblePartName} = Chart->new ({
        'version'  => '2.18.2',
        'includes' => $includes,
        'page'     => $page{'part'}, 
        'names'    => $chartNames{$visiblePartName}, 
        'book'     => $book->part( $instrumentName ) 
    }) ;
}

#  Condensed Score - Concert


