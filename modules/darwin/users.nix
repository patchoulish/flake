{ pkgs, ... }:
{
	system = {
		# The name for the primary user.
		# NOTE: This is a transient option and will be removed at some point.
		primaryUser = "patchouli";
	};
	
	users.users = {
		patchouli = {
			name = "patchouli";

			# The login shell to use.
			# Fish may be problematic for this purpose, but it sure does look pretty.
			shell = pkgs.fish;

			home = "/Users/patchouli";
		};
	};
}
