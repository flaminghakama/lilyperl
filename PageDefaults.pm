package PageDefaults ; 
use Page ; 
use Paper ; 
use Layout ; 

our %paper ; 
our %page ; 

$paper{'part'} = Paper->new
    ({ 'size'        => 'letter', 
       'orientation' => 'portrait' }) ; 

$paper{'score'} = Paper->new
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

$page{'part'} = Page->new
    ({ 'paper'      => $paper{'part'}, 
       'space'      => $space,
       'pagination' => $pagination, 
       'fonts'      => $fonts       }) ;

$page{'score'} = Page->new
    ({ 'paper'      => $paper{'score'}, 
       'space'      => $space,
       'pagination' => $pagination, 
       'fonts'      => $fonts       }) ;

our $layout = Layout->new
    ({ 'indent'            => '3\cm',
        'shortIndent'      => '.25\cm',
        'chordFontSize'    => '3',
        'raggedRight'      => FALSE,
        'raggedLast'       => TRUE,
        'removeEmptyStaff' => TRUE      }) ; 

1 ; 