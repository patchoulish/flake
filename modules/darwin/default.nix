{
	imports = [
		./networking
		./services
		./nix.nix
		./users.nix
	];

	# The configuration schema version for nix-darwin.
	system.stateVersion = 6;
}
