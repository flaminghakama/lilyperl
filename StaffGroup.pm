package StaffGroup ; 
use Staff ; 

sub new {
    my $class = shift;
    my $self = shift ; 
    unless ( ref($self) eq 'HASH' ) { 
        $self = {
            name => $self,
            instruments => shift
        }
    } ;
    return bless $self, $class;
}

sub clone {
    my $self = shift;
    my $copy;
    foreach my $key (keys %$self) {
        if(ref $self->{$key}) {
            $copy->{$key} = $self->{$key}->clone(); 
        } else {
            $copy->{$key} = $self->{$key};
        }
    }
    bless $copy, ref $self;
}

sub name {
    my ( $self, $value ) = @_; 
    $self->{name} = $value if defined $value ; 
    return $self->{name};
}

#
#  Returns current instrument list if you specify nothing
#  If you supply a list of instruments (or instrument list ref), 
#      update each instrument's staffGroup property to reflect this staff group
#      and replace the instrument list with the updated list.
#
sub instruments {
    my $self = shift ; 
    my $instrumentsRef = shift ; 
    return $self->{instruments} unless $instrumentsRef ; 

    (@instruments) = ( ref($instrumentsRef) eq 'ARRAY' ) ? @$instrumentsRef : ($instrumentsRef, @_) ; 

    my $instrument ; 
    my @contextualInstruments ; 
    foreach $instrument (@instruments) {
        $instrument->staffGroup( $self->name() ) ; 
        push( @contextualInstruments, $instrument ) ; 
    }
    $self->{instruments} = \@contextualInstruments ; 
    return $self->{instruments} ; 
}

#
#  Return the instrument of the specified name.
#  If no instrument matches, return undef. 
#
sub instrument { 
    my $self = shift ; 
    my $name = shift ; 
    my $instrument ; 
    my @instruments = $self->instruments() ; 
    foreach $instrument (@instruments) {
        return $instrument if ( $instrument->name() eq $name ) ; 
    }
    return undef ; 
}

#
#  Takes as arguments: margin, musicSuffix, transposed
#
sub render {
    my $self = shift ; 
    my $margin = shift ; 
    my $indent = $margin . '    ' ;
    my $musicSuffix = shift ; 

    my @lilypond = () ; 
    $name = ( defined $self->name() ) ? '= "' . $self->name() . '" ' : '' ; 
    push( @lilypond, "$margin\\new StaffGroup $name<<") ; 

    my $instrument ; 
    my $staff ; 
    my $instrumentsRef = $self->instruments() ; 
    foreach $instrument (@$instrumentsRef) {
        $staff = $instrument->createStaff( $musicSuffix, $transposed ) ; 
        push( @lilypond, $staff->render($indent) ) ; 
    }

    push( @lilypond, "$margin>>" ) ; 
    return @lilypond ; 
}

package GrandStaff ;
use base qw(StaffGroup);

1 ;
