package Includes;
use parent 'Lilyperl' ;

sub new {
    my ($class, @files) = @_;
    my $self = {
        files  => \@files
    };
    return bless $self, $class;
}

sub files {
    my ( $self, @files ) = @_ ; 
    $self->{files} = \@files if @files ; 
    return $self->{files};
}

sub pushFiles {
    my ( $self, @newFiles ) = @_ ; 
    return $self->{files} unless @newFiles ; 
    my $filesRef = $self->files() ; 
    my @files = ( @$filesRef, @newFiles ) ; 
    return $self->files( @files ) ;
}

sub render { 
    my $self = shift ; 
    my $fileRef = $self->{files} ; 
    my @files = @{ $fileRef } ; 
    my $file ; 
    my @lilypond ; 
    foreach $file ( @files )  {
        push (@lilypond, '\include "' . $file . '"') ; 
    }
    return @lilypond ; 
}

1;
