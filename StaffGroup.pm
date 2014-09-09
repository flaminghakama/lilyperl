package StaffGroup ; 

sub new {
    my $class = shift;
    my $self = shift ; 
    unless ( ref($self) eq 'HASH' ) { 
        $self = {
            name => $self,
            staves => shift
        }
    } ;
    return bless $self, $class;
}

sub name {
    my ( $self, $value ) = @_; 
    $self->{name} = $value if defined $value ; 
    return $self->{name};
}

sub staves {
    my ( $self, $value ) = @_; 
    $self->{staves} = $value if defined $value ; 
    return $self->{staves};
}


sub render {
    my $self = shift ; 
    my $margin = shift ; 
    my $indent = $margin . '    ' ;
    my @lilypond = () ; 
    $name = ( defined $self->name() ) ? '= "' . $self->name() . '" ' : '' ; 
    push( @lilypond, "$margin\\new StaffGroup $name<<") ; 

    my $staff ; 
    my $stavesRef = $self->staves() ; 
    foreach $staff (@$stavesRef) {
        push(@lilypond, $staff->render($indent)) ; 
    }

    push( @lilypond, "$margin>>") ; 
    return @lilypond ; 
}
package GrandStaff ;
use base qw(StaffGroup);

1 ;
