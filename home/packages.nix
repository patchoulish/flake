{ pkgs, ... }:
{
	# A list of packages to install for the user.
	home.packages = with pkgs; [
		# Utilities.
		nix-output-monitor
		just
		nvd
		age
		sops

		# For fun.
		kittysay
	];
}
