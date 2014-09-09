package Part ; 
use Includes ; 
use page ; 

sub new {
    my $class = shift;
    my $self = {
        version    => shift,
        includes   => shift,
        page       => shift,
        names      => shift,
        book       => shift
    };
    return bless $self, $class;
}

sub version {
    my ( $self, $value ) = @_; 
    $self->{version} = $value if defined $value ; 
    return $self->{version};
}

sub includes {
    my ( $self, $value ) = @_; 
    $self->{includes} = $value if defined $value ; 
    return $self->{includes};
}

sub page {
    my ( $self, $value ) = @_; 
    $self->{page} = $value if defined $value ; 
    return $self->{page};
}

sub names {
    my ( $self, $value ) = @_; 
    $self->{names} = $value if defined $value ; 
    return $self->{names};
}

sub book {
    my ( $self, $value ) = @_; 
    $self->{book} = $value if defined $value ; 
    return $self->{book};
}

sub render { 
    my $self = shift ; 
    my $version = '\version "' . $self->version() . '"' ; 
    my (@includes) = $self->includes()->render() ; 
    my (@page) = $self->page()->render() ; 
    my $fileSuffix = '#(define output-suffix "' . $self->names()->pdfSuffix() . '")' ;
    $self->book()->header()->poet($self->names()->pdfPart()) ; 
    my (@book) = $self->book()->render() ;

    return (
        $version,
        @includes,
        @page,
        '',
        $fileSuffix,
        @book
    ) ; 
}

1 ;
