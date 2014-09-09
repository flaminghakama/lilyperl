lilyperl
========

Programmatic front end to the Lilypond music engraving language

Generates the pro forma markup needed to construct 
a score and individual parts for each instrument.

Manages multiple books, multiple scores per book.

Also in includes a sub-model of the Score structure, adding the concept of Sections.

For each score, an instrument's music is constructed by:
    a music definition variable for each section / instrument combination.
    (e.g., vioninIIntro, violinIMelody, violinICoda
           violaIntro, violaMelody, violaCoda
           celloIntro, celloMelody, celloCoda... )
    a constructor function that takes as arguments a set of music definitions for an instrument
    invocations of the constructor function for each instrument that define the music for an instrument (for this score)

Each score is constructed by creating the specified staff groups and staves, 
    whose content is simply the variable created by the invocation of the constructor function

Also includes a meta-structure called Chart, which models a lilypond file 
    with version, includes, paper definitions as well as the book.


Book: models the Lilypond book structure, with added information relevant to 
Book.pm:sub new {
Book.pm:sub name {
Book.pm:sub version {
Book.pm:sub includes {
Book.pm:sub page {
Book.pm:sub header {
Book.pm:sub scores {
Book.pm:sub addScores {
Book.pm:sub transposed {
Book.pm:sub createConstructorFunctions {
Book.pm:sub musicDefinitions {
Book.pm:sub writeMusicDefinitionsFiles {
Book.pm:sub getStaffGroups {
Book.pm:sub sequenceMeasureNumbers {
Book.pm:sub instruments {
Book.pm:sub parts { 
Book.pm:sub part {
Book.pm:sub render {

Chart.pm:sub new {
Chart.pm:sub includes {
Chart.pm:sub page {
Chart.pm:sub names {
Chart.pm:sub book {
Chart.pm:sub render { 

ChartNames.pm:sub new {
ChartNames.pm:sub chartName {
ChartNames.pm:sub pdfFileSuffix {
ChartNames.pm:sub visiblePartName {

Context.pm:sub new {
Context.pm:sub context {
Context.pm:sub value {

Fonts.pm:sub new {
Fonts.pm:sub main {
Fonts.pm:sub secondary {
Fonts.pm:sub chords {
Fonts.pm:sub render {

Header.pm:sub new {
Header.pm:sub piece {
Header.pm:sub source {
Header.pm:sub style {
Header.pm:sub copyright {
Header.pm:sub lastupdated {
Header.pm:sub title {
Header.pm:sub titleFontSize {
Header.pm:sub poet {
Header.pm:sub composer {
Header.pm:sub arranger {
Header.pm:sub tagline {
Header.pm:sub render {

Includes.pm:sub new {
Includes.pm:sub files {
Includes.pm:sub render { 

Instrument.pm:sub new {
Instrument.pm:sub instrumentName {
Instrument.pm:sub shortInstrumentName {
Instrument.pm:sub midiInstrument {
Instrument.pm:sub clef {
Instrument.pm:sub transposition {
Instrument.pm:sub staff {
Instrument.pm:sub createStaff {
Instrument.pm:sub include {
Instrument.pm:sub new {
Instrument.pm:sub clefBelow {

Layout.pm:sub new {
Layout.pm:sub indent {
Layout.pm:sub shortIndent {
Layout.pm:sub chordFontSize {
Layout.pm:sub raggedRight {
Layout.pm:sub raggedLast {
Layout.pm:sub removeEmptyStaff {
Layout.pm:sub render {

MusicDefinitions.pm:sub new {
MusicDefinitions.pm:sub functions {
MusicDefinitions.pm:sub pushFunction {
MusicDefinitions.pm:sub functionsFilename {
MusicDefinitions.pm:sub functionsInclude {
MusicDefinitions.pm:sub staffGroupIncludes {
MusicDefinitions.pm:sub pushStaffGroupIncludes {

Page.pm:sub new {
Page.pm:sub paper {
Page.pm:sub space {
Page.pm:sub pagination {
Page.pm:sub fonts {
Page.pm:sub render {

Pagination.pm:sub new {
Pagination.pm:sub printPageNumberFirst {
Pagination.pm:sub printPageNumberNext {
Pagination.pm:sub titleSplitLeft {
Pagination.pm:sub titleSplitRight {

Paper.pm:sub new {
Paper.pm:sub definePaperSize {
Paper.pm:sub size {
Paper.pm:sub orientation {
Paper.pm:sub render { 

Score.pm:sub new {
Score.pm:sub name {
Score.pm:sub sections {
Score.pm:sub header {
Score.pm:sub startingBarNumber {
Score.pm:sub barNumberVisibility {
Score.pm:sub doubleRepeatType {
Score.pm:sub staffGroups {
Score.pm:sub layout {
Score.pm:sub listSectionNames {
Score.pm:sub howManyMeasures {
Score.pm:sub constructorFunction {
Score.pm:sub conditionalPush {
Score.pm:sub pushConstructorIf {
Score.pm:sub createConstructorFunction {
Score.pm:sub createMusicDefinitions {
Score.pm:sub createChordDefinitions {
Score.pm: sub instruments {
Score.pm:sub getInstrument { 
Score.pm:sub render {

Section.pm:sub new {
Section.pm:sub name {
Section.pm:sub displayName {
Section.pm:sub key {
Section.pm:sub tempo {
Section.pm:sub timeSignature {
Section.pm:sub howManyMeasures {
Section.pm:sub defaultMusic {
Section.pm:sub defaultChords {

Space.pm:sub new {
Space.pm:sub afterHeaderFirstPage {
Space.pm:sub afterHeaderNextPage {
Space.pm:sub betweenSystems {
Space.pm:sub betweenTopOfPageAndHeader {
Space.pm:sub render {

Staff.pm:sub new {
Staff.pm:sub instrumentName {
Staff.pm:sub shortInstrumentName {
Staff.pm:sub midiInstrument {
Staff.pm:sub clef {
Staff.pm:sub music {
Staff.pm:sub musicTransposeFrom {
Staff.pm:sub musicTransposeTo {
Staff.pm:sub chordSequence {
Staff.pm:sub chordTransposeFrom {
Staff.pm:sub chordTransposeTo {
Staff.pm:sub transpose {
Staff.pm:sub transposeMusic {
Staff.pm:sub reverseTransposeMusic {
Staff.pm:sub transposeChords {
Staff.pm:sub reverseTransposeChords {
Staff.pm:sub lilypond {
Staff.pm:sub lilypush {
Staff.pm:sub conditionalLily {
Staff.pm:sub render {
Staff.pm:sub render {
Staff.pm:sub new {
Staff.pm:sub clefBelow {
Staff.pm:sub musicBelow {
Staff.pm:sub musicTransposeFromBelow {
Staff.pm:sub musicTransposeToBelow {
Staff.pm:sub chordSequenceBelow {
Staff.pm:sub chordTransposeFromBelow {
Staff.pm:sub chordTransposeToBelow {
Staff.pm:sub render {

StaffGroup.pm:sub new {
StaffGroup.pm:sub name {
StaffGroup.pm:sub instruments {
StaffGroup.pm:sub instrument { 
StaffGroup.pm:sub render {

