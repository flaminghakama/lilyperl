package Paper ; 
use Page ; 
use Space ; 
use Pagination ; 
use Fonts ; 

sub new {
    my $class = shift;
    my $self = shift ; 
    unless ( ref($self) eq 'HASH' ) { 
        $self = {
            page => $self, 
            space => shift,
            pagination => shift, 
            fonts => shift
        }
    } ; 
    return bless $self, $class;
}

sub page {
    my ( $self, $value ) = @_; 
    $self->{page} = $value if defined $value ; 
    return $self->{page};
}

sub space {
    my ( $self, $value ) = @_; 
    $self->{space} = $value if defined $value ; 
    return $self->{space};
}

sub pagination {
    my ( $self, $value ) = @_; 
    $self->{pagination} = $value if defined $value ; 
    return $self->{pagination};
}

sub fonts {
    my ( $self, $value ) = @_; 
    $self->{fonts} = $value if defined $value ; 
    return $self->{fonts};
}

sub render {
    my $self = shift ; 

    my $margin = shift ; 
    my $indent = $margin . '    ' ;
    my $pageNumberFirst = ( $self->pagination()->printPageNumberFirst() ) ? '##t' : '##f' ; 
    my $pageNumberNext = ( $self->pagination()->printPageNumberNext() ) ? '##t' : '##f' ;  
    my $titleSplitLeft = $self->pagination()->titleSplitLeft() ;
    my $titleSplitRight = $self->pagination()->titleSplitRight() ; 
    my (@spacing) = $self->space()->render() ; 

    my @lilypond = ( 
            $self->{page}->render(),
            $self->fonts()->render(), 
            '\paper {',
            $indent . "print-page-number = $pageNumberFirst",
            $indent . "print-first-page-number = $pageNumberFirst",
            q^
    oddHeaderMarkup = \markup {
        \fill-line {
            \on-the-fly #print-page-number-check-first
            \fromproperty #'header:poet
            \on-the-fly #print-page-number-check-first^,  
            "$indent$indent$indent\"                              $titleSplitLeft --\"", q^
            \on-the-fly #print-page-number-check-first
            \fromproperty #'page:page-number-string
            \on-the-fly #print-page-number-check-first^,
            "$indent$indent$indent\"-- $titleSplitRight                                 \"", q^
            \on-the-fly #print-page-number-check-first
            \fromproperty #'header:composer
        }
    }
    evenHeaderMarkup = \oddHeaderMarkup
    oddFooterMarkup = \markup { \fill-line { \fromproperty #'header:copyright } }
    evenFooterMarkup = \oddFooterMarkup
^,
            @spacing, 
            '}'
        );

    return @lilypond ; 
}
1 ;
