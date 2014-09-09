package Book ; 
use Paper ; 
use Header ; 
use ScoreDefaults ; 

sub new {
    my $class = shift;
    my $self = shift ; 

    unless( ref($self) eq 'HASH' ) { 
        $self = {
            paper => $self, 
            header => shift,
            scoreDefaults => shift, 
            scores => shift
        } ; 
    }

    return bless $self, $class;
}

sub paper {
    my ( $self, $value ) = @_; 
    $self->{paper} = $value if defined $value ; 
    return $self->{paper};
}

sub header {
    my ( $self, $value ) = @_; 
    $self->{header} = $value if defined $value ; 
    return $self->{header};
}

sub scoreDefaults {
    my ( $self, $value ) = @_; 
    $self->{scoreDefaults} = $value if defined $value ; 
    return $self->{scoreDefaults};
}

sub scores {
    my ( $self, $value ) = @_; 
    $self->{scores} = $value if defined $value ; 
    return $self->{scores};
}

sub render {
    my $self = shift ; 
    my $margin = shift ; 
    my $indent = $margin . '    ' ; 
    my @lilypond = ( "book {" ) ; 

    if ( $self->paper() ) {  
        push( @lilypond,
              $indent . '\paper {', 
              $self->paper()->space()->render($indent),
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
    foreach $score (@$scoresRef) {
        push( @lilypond, $score->render($indent) ) ; 
    }

    push( @lilypond, '}' ) ; 

    return @lilypond ;
}

1 ; 
