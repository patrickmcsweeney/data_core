$c->add_dataset_field( "document", { name=>"derived_from", type=>"url", multiple=>1, required=>0, } );
$c->add_dataset_field( "document", { name=>"derived_using", type=>"url", multiple=>1, required=>0, } );
$c->add_dataset_field( "document", { name=>"derived_notes", type=>"longtext", required=>0, } );

$c->{skip_buffer} = 1;
$c->{plugin_alias_map}->{"Screen::EPrint::Edit"} = "Screen::EPrint::DataEdit";
$c->{plugin_alias_map}->{"Screen::EPrint::DataEdit"} = undef;
$c->{plugins}->{"Screen::EPrint::DataEdit"}->{params}->{disable} = 0;

$c->{set_eprint_defaults} = sub
{
        my( $data, $repository ) = @_;

        $data->{type} = "dataset";

	my $user = $repository->current_user;
        if(defined $user)
        {
                my %creator;
                $creator{name} = $user->get_value("name");
                $creator{id} = $user->get_value("email");
                my @creators;
                $creators[0] = \%creator;
                $data->{creators} = \@creators;
        }

};

$c->{"data_choose_workflow"} = sub {
        my ( $eprint ) = @_;

        my $type = $eprint->value("type");

        if($type eq "dataset")
        {
                return "data_core";
        }

        return "default";

};

