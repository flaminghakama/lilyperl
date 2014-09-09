package Fonts ; 
sub new {
    my $class = shift;
    my $self = shift ; 

    unless ( ref($self) eq 'HASH' ) { 
        $self = {
            main => $self, 
            secondary => shift,
            chords => shift
        } ;
    }

    return bless $self, $class;
}

sub main {
    my ( $self, $value ) = @_; 
    $self->{fileSuffix} = $value if defined $value ; 
    $self->{main} = $value if defined $value ; 
    return $self->{main};
}

sub secondary {
    my ( $self, $value ) = @_; 
    $self->{fileSuffix} = $value if defined $value ; 
    $self->{secondary} = $value if defined $value ; 
    return $self->{secondary};
}

sub chords {
    my ( $self, $value ) = @_; 
    $self->{fileSuffix} = $value if defined $value ; 
    $self->{chords} = $value if defined $value ; 
    return $self->{chords};
}

sub render {
    my $self = shift ; 
    my @lilypond = (
           '\paper {',
            '  #(define fonts',
            '     (make-pango-font-tree "' . $self->main() . '"',
            '                           "' . $self->secondary() . '"', 
            '                           "' . $self->chords() . '"',
            '                           (/ myStaffSize 20)))',
            '}'
        ) ; 
    return @lilypond ; 
}
1 ;
