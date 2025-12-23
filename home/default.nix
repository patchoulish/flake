{ ... }:
{
	imports = [
		./programs
		./wayland
		./fonts.nix
		./packages.nix
	];

	# Use XDG directories whenever supported.
	home.preferXdgDirectories = true;
}
