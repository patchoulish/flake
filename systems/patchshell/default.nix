{
	imports = [
		./networking.nix
		./wsl.nix
	];

	flake.system = {
		services = {
			nebula = {
				enable = true;
			};
		};
	};
}
