package Lilyperl ; 

sub arrayClone {
    my $self = shift ; 
    my $itemsRef = shift ; 
    my @items = @$itemsRef ; 
    my $item ; 
    my @copy ; 
    foreach $item ( @items ) { 
        if( ref($item) eq 'ARRAY' )  {
            my $cloneArrayRef = $self->arrayClone( $item ) ; 
            push( @copy, $cloneArrayRef ) ; 
        } else {
            if ( ref $self->{$key} ) {
                push( @copy, $item->clone() ) ; 
            } else {
                push( @copy, $item );
            }
        }
    }
    return \@copy ; 
}

sub clone {
    my $self = shift;
    my $copy;
    foreach my $key (keys %$self) {
        if( ref($self->{$key}) eq 'ARRAY' )  {
            my $cloneArrayRef = $self->arrayClone( $self->{$key} ) ; 
            $copy->{$key} = $cloneArrayRef ; 
        } else {
            if ( ref $self->{$key} ) {
                $copy->{$key} = $self->{$key}->clone(); 
            } else {
                $copy->{$key} = $self->{$key};
            }
        }
    }
    bless $copy, ref $self;
    return $copy ; 
}

1 ; 
