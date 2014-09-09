package PageDefaults ; 
use Page ; 

use constant { TRUE => 1, FALSE = 0 } ; 

my %paper ; 
my %page ; 

my $paper{'part'} = Paper->new
    ({ 'size'        => 'letter', 
       'orientation' => 'portrait' }) ; 

my $paper{'score'} = Paper->new
    ({ 'size'        => 'poster', 
       'orientation' => 'landscape' }) ; 

$paper{'score'}->definePaperSize(
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

my $page{'part'} = Page->new
    ({ 'page'       => $partPage, 
       'space'      => $space,
       'pagination' => $pagination, 
       'fonts'      => $fonts       }) ;

my $page{'score'} = Page->new
    ({ 'page'       => $scorePage, 
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

1 ; 