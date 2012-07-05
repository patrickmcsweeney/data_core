package EPrints::Plugin::Screen::EPrint::DataEdit;

@ISA = ( 'EPrints::Plugin::Screen::EPrint::Edit' );

use strict;

sub workflow_id
{
	my ( $self ) = @_;

	my $repo = $self->{repository};

	if ( $repo->can_call("data_choose_workflow") )
	{
		return $repo->call("data_choose_workflow", $self->{processor}->{eprint} );
	}

	return "default";
}
