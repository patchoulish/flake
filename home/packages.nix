{ pkgs, ... }:
{
	# A list of packages to install for the user.
	home.packages = with pkgs; [
		# Utilities.
		just
		nvd
		age
		sops

		# For fun.
		kittysay
	];
}
