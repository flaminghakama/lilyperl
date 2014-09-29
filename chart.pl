#!/usr/bin/perl   

use strict;
use warnings;
use Roman;
use parent 'Clone';

use Book ;
use PageDefaults ; 
use Chart ; 

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
my %page = %PageDefaults::page ; 
$page{'part'}->pagination()->titleSplitLeft('As It') ; 
$page{'part'}->pagination()->titleSplitRight('Is') ; 
$page{'score'}->pagination()->titleSplitLeft('As It') ; 
$page{'score'}->pagination()->titleSplitRight('Is') ; 

$page{'part'}->fonts()->main('Agatha') ; 
$page{'score'}->fonts()->main('Agatha') ; 

my %paper = %PageDefaults::paper ; 
my $layout = $PageDefaults::layout ; 

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

my $section = Section->new({
    'name'            => 'Fanfare',
    'displayName'     => 'Fanfare',
    'key'             => 'e \minor',
    'tempo'           => '\tempo "Afro-Latin " 2=104',
    'timeSignature'   => "\\time 2/2",
    'howManyMeasures' => 12,
    'defaultMusic'    => 'R1 * 12',
    'defaultChords'   => 'R1 * 12'
}) ; 
push( @{$sections{'Intro'}}, $section ) ; 

$section = Section->new({
    'name'            => 'Buildup',
    'displayName'     => 'Buildup',
    'howManyMeasures' => 16,
    'defaultMusic'    => 'R1 * 16',
    'defaultChords'   => 'e1:m e:m e:m e:m   e:m e:m e:m e:m   e:m e:m e:m e:m   e:m e:m e:m e:m'
}) ;
push( @{$sections{'Intro'}}, $section ) ; 


$section = Section->new({
    'name'            => 'ChorusI',
    'displayName'     => 'Solo',
    'howManyMeasures' => 16,
    'defaultMusic'    => 'R1 * 16',
    'defaultChords'   => 'e1:m e:m e:m e:m   e:m e:m e:m e:m   e:m e:m e:m e:m   e:m e:m e:m e:m'
}) ; 
push( @{$sections{'FirstSolo'}}, $section ) ; 

$section = Section->new({
    'name'            => 'ChorusII',
    'displayName'     => '(add Trb.)',
    'howManyMeasures' => 16,
    'defaultMusic'    => 'R1 * 16', 
    'defaultChords'   => 'e1:m e:m e:m e:m   e:m e:m e:m e:m   e:m e:m e:m e:m   e:m e:m e:m e:m'
}) ; 
push( @{$sections{'FirstSolo'}}, $section ) ; 

$section = Section->new({
    'name'            => 'ChorusIII',
    'displayName'     => '(add Trp.)',
    'howManyMeasures' => 16,
    'defaultMusic'    => 'R1 * 16',
    'defaultChords'   => 'e1:m e:m e:m e:m   e:m e:m e:m e:m   e:m e:m e:m e:m   e:m e:m e:m e:m'
}) ; 
push( @{$sections{'FirstSolo'}}, $section ) ; 

$section = Section->new({
    'name'            => 'ChorusIV',
    'displayName'     => '(add Sax)',
    'howManyMeasures' => 16,
    'defaultMusic'    => 'R1 * 16',
    'defaultChords'   => 'e1:m e:m e:m e:m   e:m e:m e:m e:m   e:m e:m e:m e:m   e:m e:m e:m e:m'
}) ; 
push( @{$sections{'FirstSolo'}}, $section ) ; 


$section = Section->new({
    'name'            => 'Fanfare',
    'displayName'     => 'Fanfare',
    'howManyMeasures' => 16,
    'defaultMusic'    => 'R1 * 16',
    'defaultChords'   => 'R1 * 16'
}) ; 
push( @{$sections{'HeadIn'}}, $section ) ; 

$section = Section->new({
    'name'            => 'HeadI',
    'displayName'     => 'Head',
    'howManyMeasures' => 16,
    'defaultMusic'    => 'R1 * 16',
    'defaultChords'   => 'e1:m e:m e:m e:m',
}) ; 
push( @{$sections{'HeadIn'}}, $section ) ; 

$section = Section->new({
    'name'            => 'HeadII',
    'displayName'     => '',
    'howManyMeasures' => 16,
    'defaultMusic'    => 'R1 * 16',
    'defaultChords'   => 'e1:m e:m e:m e:m',
}) ; 
push( @{$sections{'HeadIn'}}, $section ) ; 



$section = Section->new({
    'name'            => 'ChorusI',
    'displayName'     => 'Solo',
    'howManyMeasures' => 16,
    'defaultMusic'    => 'R1 * 16',
    'defaultChords'   => 'e1:m e:m e:m e:m',
}) ; 
push( @{$sections{'SecondSolo'}}, $section ) ; 

$section = Section->new({
    'name'            => 'ChorusII',
    'displayName'     => '(add I)',
    'howManyMeasures' => 16,
    'defaultMusic'    => 'R1 * 16',
    'defaultChords'   => 'e1:m e:m e:m e:m',
}) ; 
push( @{$sections{'SecondSolo'}}, $section ) ; 

$section = Section->new({
    'name'            => 'ChorusIII',
    'displayName'     => '(add II)',
    'howManyMeasures' => 16,
    'defaultMusic'    => 'R1 * 16',
    'defaultChords'   => 'e1:m e:m e:m e:m',
}) ; 
push( @{$sections{'SecondSolo'}}, $section ) ; 

$section = Section->new({
    'name'            => 'ChorusIV',
    'displayName'     => '(add III)',
    'howManyMeasures' => 16,
    'defaultMusic'    => 'R1 * 16',
    'defaultChords'   => 'e1:m e:m e:m e:m',
}) ; 
push( @{$sections{'SecondSolo'}}, $section ) ; 

$section = Section->new({
    'name'            => 'HeadIII',
    'displayName'     => 'Head',
    'howManyMeasures' => 16,
    'defaultMusic'    => 'R1 * 16',
    'defaultChords'   => 'e1:m e:m e:m e:m',
}) ; 
push( @{$sections{'SecondSolo'}}, $section ) ; 

$section = Section->new({
    'name'            => 'HeadIV',
    'displayName'     => '',
    'howManyMeasures' => 16,
    'defaultMusic'    => 'R1 * 16',
    'defaultChords'   => 'e1:m e:m e:m e:m',
}) ; 
push( @{$sections{'SecondSolo'}}, $section ) ; 
  

$section = Section->new({
    'name'            => 'ChorusI',
    'displayName'     => 'Solo',
    'howManyMeasures' => 16,
    'defaultMusic'    => 'R1 * 16',
    'defaultChords'   => 'e1:m e:m e:m e:m',
}) ; 
push( @{$sections{'ThirdSolo'}}, $section ) ; 

$section = Section->new({
    'name'            => 'ChorusII',
    'displayName'     => '(add I)',
    'howManyMeasures' => 16,
    'defaultMusic'    => 'R1 * 16',
    'defaultChords'   => 'e1:m e:m e:m e:m',
}) ; 
push( @{$sections{'ThirdSolo'}}, $section ) ; 

$section = Section->new({
    'name'            => 'ChorusIII',
    'displayName'     => '(add II)',
    'howManyMeasures' => 16,
    'defaultMusic'    => 'R1 * 16',
    'defaultChords'   => 'e1:m e:m e:m e:m',
}) ; 
push( @{$sections{'ThirdSolo'}}, $section ) ; 

$section = Section->new({
    'name'            => 'ChorusIV',
    'displayName'     => '(add III)',
    'howManyMeasures' => 16,
    'defaultMusic'    => 'R1 * 16',
    'defaultChords'   => 'e1:m e:m e:m e:m',
}) ; 
push( @{$sections{'ThirdSolo'}}, $section ) ; 

$section = Section->new({
    'name'            => 'ChorusIVEnding',
    'displayName'     => '',
    'howManyMeasures' => 1,
    'defaultMusic'    => 'R1 * 16',
    'defaultChords'   => 'e1:m e:m e:m e:m',
}) ; 
push( @{$sections{'ThirdSolo'}}, $section ) ; 


$section = Section->new({
    'name'            => 'LastEnding',
    'displayName'     => '',
    'howManyMeasures' => 16,
    'defaultMusic'    => 'R1 * 16',
    'defaultChords'   => 'e1:m e:m e:m e:m',
}) ; 
push( @{$sections{'HeadOut'}}, $section ) ; 

$section = Section->new({
    'name'            => 'Fanfare',
    'displayName'     => 'Fanfare',
    'howManyMeasures' => 16,
    'defaultMusic'    => 'R1 * 16',
    'defaultChords'   => 'e1:m e:m e:m e:m',
}) ; 
push( @{$sections{'HeadOut'}}, $section ) ; 

$section = Section->new({
    'name'            => 'HeadV',
    'displayName'     => 'Head',
    'howManyMeasures' => 16,
    'defaultMusic'    => 'R1 * 16',
    'defaultChords'   => 'e1:m e:m e:m e:m',
}) ; 
push( @{$sections{'HeadOut'}}, $section ) ; 

$section = Section->new({
    'name'            => 'HeadVI',
    'displayName'     => '',
    'howManyMeasures' => 16,
    'defaultMusic'    => 'R1 * 16',
    'defaultChords'   => 'e1:m e:m e:m e:m',
}) ; 
push( @{$sections{'HeadOut'}}, $section ) ; 

 $section = Section->new({
    'name'            => 'Coda',
    'displayName'     => '',
    'howManyMeasures' => 16,
    'defaultMusic'    => 'R1 * 16',
    'defaultChords'   => 'e1:m e:m e:m e:m',
}) ; 
push( @{$sections{'HeadOut'}}, $section ) ; 


#
#  Initialize Scores with Score Sections
#
#  Create rehearsal marks file 
#      For each score
#          Create function definition with score sections as parameters
#
my $scoreName ; 
my @functions ; 
my $lastBarNumber = 0 ; 
foreach $scoreName (@scoreNames) {

    my $score = Score->new({
       'name'                 => $scoreName,
       'sections'             => $sections{$scoreName},
       'layout'               => $layout
    }) ;
    $score->startingBarNumber( $lastBarNumber + 1 ) ;
    push( @scores, $score ) ; 
    #my $constructorFunction = $score->createConstructorFunction( '\bar "||"' ) ; 
    #push( @functions, $constructorFunction ) ; 
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

my $instrument ; 
my %instrumentSection ; 

$instrument = Instrument->new ({
    'name'                => 'oboe',
    'instrumentName'      => 'Oboe',
    'shortInstrumentName' => 'Oboe',
    'midiInstrument'      => 'oboe',
    'clef'                => 'treble',
    'transposition'       => 'c'
}) ;
push( @{$instrumentSection{'Woodwinds'}}, $instrument ) ; 


$instrument = Instrument->new ({
    'name'                => 'altoI',
    'instrumentName'      => 'Eb Alto Saxophone I',
    'shortInstrumentName' => 'Alto I',
    'midiInstrument'      => 'alto saxopohone',
    'clef'                => 'treble',
    'transposition'       => 'ef'
}) ;
push( @{$instrumentSection{'Saxophones'}}, $instrument) ; 

$instrument = Instrument->new ({
    'name'                => 'altoII',
    'instrumentName'      => 'Eb Alto Saxophone II',
    'shortInstrumentName' => 'Alto II',
    'midiInstrument'      => 'alto saxopohone',
    'clef'                => 'treble',
    'transposition'       => 'ef'
}) ;
push( @{$instrumentSection{'Saxophones'}}, $instrument) ; 

$instrument = Instrument->new ({
    'name'                => 'tenorI',
    'instrumentName'      => 'Bb tenor Saxophone I',
    'shortInstrumentName' => 'Tenor I',
    'midiInstrument'      => 'tenor saxopohone',
    'clef'                => 'treble',
    'transposition'       => 'bf'
}) ;
push( @{$instrumentSection{'Saxophones'}}, $instrument) ; 

$instrument = Instrument->new ({
    'name'                => 'tenorII',
    'instrumentName'      => 'Bb tenor Saxophone II',
    'shortInstrumentName' => 'Tenor II',
    'midiInstrument'      => 'tenor saxopohone',
    'clef'                => 'treble',
    'transposition'       => 'bf'
}) ;
push( @{$instrumentSection{'Saxophones'}}, $instrument) ; 

$instrument = Instrument->new ({
    'name'                => 'bari',
    'instrumentName'      => 'Bb Baritone Saxophone',
    'shortInstrumentName' => 'Bari',
    'midiInstrument'      => 'baritone saxophone',
    'clef'                => 'treble',
    'transposition'       => 'ef'
}) ;
push( @{$instrumentSection{'Saxophones'}}, $instrument) ; 


$instrument = Instrument->new ({
    'name'                => 'trumpetI',
    'instrumentName'      => 'Bb Trumpet I',
    'shortInstrumentName' => 'Trp. I',
    'midiInstrument'      => 'trumpet',
    'clef'                => 'treble',
    'transposition'       => 'bf'
}) ;
push( @{$instrumentSection{'Trumpets'}}, $instrument) ; 

$instrument = Instrument->new ({
    'name'                => 'trumpetII',
    'instrumentName'      => 'Bb Trumpet II',
    'shortInstrumentName' => 'Trp. II',
    'midiInstrument'      => 'trumpet',
    'clef'                => 'treble',
    'transposition'       => 'bf'
}) ;
push( @{$instrumentSection{'Trumpets'}}, $instrument) ; 

$instrument = Instrument->new ({
    'name'                => 'trumpetIII',
    'instrumentName'      => 'Bb Trumpet III',
    'shortInstrumentName' => 'Trp. III',
    'midiInstrument'      => 'trumpet',
    'clef'                => 'treble',
    'transposition'       => 'bf'
}) ;
push( @{$instrumentSection{'Trumpets'}}, $instrument) ; 

$instrument = Instrument->new ({
    'name'                => 'trumpetIV',
    'instrumentName'      => 'Bb Trumpet IV',
    'shortInstrumentName' => 'Trp. IV',
    'midiInstrument'      => 'trumpet',
    'clef'                => 'treble',
    'transposition'       => 'bf'
}) ;
push( @{$instrumentSection{'Trumpets'}}, $instrument) ; 


$instrument = Instrument->new ({
    'name'                => 'horn',
    'instrumentName'      => 'F Horn',
    'shortInstrumentName' => 'Hrn.',
    'midiInstrument'      => 'french horn',
    'clef'                => 'treble',
    'transposition'       => 'f'
}) ;
push( @{$instrumentSection{'Horns'}}, $instrument) ; 


$instrument = Instrument->new ({
    'name'                => 'tromboneI',
    'instrumentName'      => 'Trombone I',
    'shortInstrumentName' => 'Trb. I',
    'midiInstrument'      => 'trombone',
    'clef'                => 'treble',
    'transposition'       => 'c'
}) ;
push( @{$instrumentSection{'Trombones'}}, $instrument) ; 

$instrument = Instrument->new ({
    'name'                => 'tromboneII',
    'instrumentName'      => 'Trombone II',
    'shortInstrumentName' => 'Trb. II',
    'midiInstrument'      => 'trombone',
    'clef'                => 'treble',
    'transposition'       => 'c'
}) ;
push( @{$instrumentSection{'Trombones'}}, $instrument) ; 

$instrument = Instrument->new ({
    'name'                => 'tromboneIII',
    'instrumentName'      => 'Trombone III',
    'shortInstrumentName' => 'Trb. III',
    'midiInstrument'      => 'trombone',
    'clef'                => 'treble',
    'transposition'       => 'c'
}) ;
push( @{$instrumentSection{'Trombones'}}, $instrument) ; 

$instrument = Instrument->new ({
    'name'                => 'tromboneIV',
    'instrumentName'      => 'Trombone IV',
    'shortInstrumentName' => 'Trb. IV',
    'midiInstrument'      => 'trombone',
    'clef'                => 'treble',
    'transposition'       => 'c'
}) ;
push( @{$instrumentSection{'Trombones'}}, $instrument) ; 


$instrument = Instrument->new ({
    'name'                => 'drums',
    'instrumentName'      => 'Drums',
    'shortInstrumentName' => 'Drums',
    'midiInstrument'      => 'drums'
}) ;
push( @{$instrumentSection{'Rhythm'}}, $instrument) ; 

$instrument = Instrument->new ({
    'name'                => 'piano',
    'instrumentName'      => 'Piano',
    'shortInstrumentName' => 'piano',
    'midiInstrument'      => 'piano',
    'clef'                => 'treble',
    'transposition'       => 'c',
    'clefBelow'           => 'bass'
}) ;
push( @{$instrumentSection{'Rhythm'}}, $instrument) ; 

$instrument = Instrument->new ({
    'name'                => 'guitar',
    'instrumentName'      => 'Guitar',
    'shortInstrumentName' => 'Gtr.',
    'midiInstrument'      => 'guitar',
    'clef'                => 'treble',
    'transposition'       => 'c'
}) ;
push( @{$instrumentSection{'Rhythm'}}, $instrument) ; 

$instrument = Instrument->new ({
    'name'                => 'bass',
    'instrumentName'      => 'Bass',
    'shortInstrumentName' => 'Bass',
    'midiInstrument'      => 'bass',
    'clef'                => 'bass',
    'transposition'       => 'c'
}) ;
push( @{$instrumentSection{'Rhythm'}}, $instrument) ; 


#
#  Add instrument sections (staff groups) to scores
#
my $score ; 
my $instrumentSectionName ; 
my @instruments ; 
foreach $score (@scores) {

    foreach $instrumentSectionName (@instrumentSections) {
        
        my $staffGroup = StaffGroup->new({
           'name'        => $instrumentSectionName,
           'instruments' => $instrumentSection{$instrumentSectionName},
        }) ;
        $score->pushStaffGroups( $staffGroup ) ; 
    }
}


#########################
#    Create the book    #
#########################

my %book ; 
my $bookName = 'As It Is' ; 
$book{'master'} = Book->new({ 
    'name'       => $bookName,
    'version'    => '2.18.2',
    'includes'   => $includes,
    'paper'      => $paper{'score'},
    'header'     => $header,  
    'scores'     => \@scores, 
    'transposed' => 'Transposed'       
}) ;

#
#  Create a rehearsal marks function file
#
my $fh ; 
my %fh ; 
my %filename ; 
my %includes ; 
my $filename = 'rehearsal-marks.ly' ; 
open( $fh, '>', $filename ) or 
    die "Could not open rehearsal marks file '$filename': " . $! ; 
print "$filename\n" ; 

my $functionsRef = $book{'master'}->createConstructorFunctions( $filename{'rehearsalMarks'} ) ; 
print $fh join("\n", @$functionsRef, '') ; 
close $fh;

my @includes = ( 'english.ly' ); 
$includes{'global'} = ( \@includes ) ;

#
#  Create music definition files for each InstrumentSection ( StaffGroup )
#      adds to staffGroupIncludes the rehearsal marks file 
#      music definition for instrument-score-section with defaultMusic
#      chords definition for instrument-score-section with defaultChords
#      rehearsal marks invocation for instrument-score 
#
my $musicDir = 'music' ; 
$book{'master'}->writeMusicDefinitionsFiles( $musicDir ) ; 

#
#  For each score,
#      Create chart for score - transposed
#      Create chart for condensed score - concert  
#
my $scoresRef = $book{'master'}->scores() ; 
@scores = @$scoresRef ; 
my $suffix ; 
my $visiblePartName ;
my %chartNames ; 
my @theseScores ; 
my %chart ; 
my $scoreNumber = 0 ; 
my $scoreNumeral; 
my $lastNumber = 0 + @scores ; 
my $lastNumeral = Roman($lastNumber) ; 
my @rendered ; 

foreach $score (@scores) {

    $scoreName = $score->name() ; 
    ++$scoreNumber ;
    $scoreNumeral = Roman($scoreNumber);

    foreach $suffix ( 'Transposed', 'Concert' ) { 

        $filename = 'scores/' . $score->name() . '-' . $suffix . '.ly' ; 
        open( $fh, '>', $filename ) or 
            die "Could not open score file '$filename': " . $! ;  
        print "$filename\n" ; 
        $visiblePartName = "Score - $scoreNumeral of $lastNumeral: $scoreName ($suffix)" ; 

        $chartNames{$visiblePartName} = ChartNames->new ({ 
            'chartName'       => $scoreName,     
            'visiblePartName' => $visiblePartName 
        }) ; 

        @theseScores = ( $score ) ;
        $book{$visiblePartName} = Book->new ({
            'name'       => $bookName . $score->name(), 
            'scores'     => \@theseScores,
            'transposed' => $suffix eq 'Transposed' 
        }) ;

        $chart{$visiblePartName} = Chart->new ({
            'version'  => '2.18.2',
            'includes' => $includes,
            'page'     => $page{'score'}, 
            'names'    => $chartNames{$visiblePartName}, 
            'book'     => $book{$visiblePartName}
        }) ; 

        (@rendered) = $chart{$visiblePartName}->render() ; 
        print $fh join("\n", @rendered, '') ; 
        close $fh ; 
    }
}


#
#      Create chart for full score - transposed
#
$filename = 'scores/Transposed.ly' ; 
open( $fh, '>', $filename ) or 
    die "Could not open score file '$filename': " . $! ;  
print "$filename\n" ; 
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

(@rendered) = $chart{$visiblePartName}->render() ; 
print $fh join("\n", @rendered, '') ; 
close $fh ; 


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

(@rendered) = $chart{$scoreName}->render() ;
print $fh join("\n", @rendered, '') ; 
close $fh  ; 

#
#      For each instrument, 
#          Create chart for part - transposed
#
my $instrumentName ; 
@instruments = $book{'master'}->instruments() ;
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

