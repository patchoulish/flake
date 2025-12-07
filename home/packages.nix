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

		hyprpicker

		# Temporary- use gh or something instead.
		github-desktop

		# For fun.
		kittysay
	];
}
