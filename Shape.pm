package Shape;

sub new {
    my ($class, $args) = @_;
    my $self = {
        color  => $args->{color} || 'black',
        length => $args->{length} || 1,
        width  => $args->{width} || 1,
    };
    return bless $self, $class;
}

sub get_area {
    my $self = shift;
    my $area = $self->{length} * $self->{width};
    return $area;
}

1;
