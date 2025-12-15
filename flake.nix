{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

		nixos-wsl = {
			url = "github:nix-community/NixOS-WSL/release-25.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		home-manager = {
			url = "github:nix-community/home-manager/release-25.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		stylix = {
			url = "github:nix-community/stylix/release-25.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		disko = {
			url = "github:nix-community/disko";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nix-darwin = {
			url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		flake-parts = {
			url = "github:hercules-ci/flake-parts";
			inputs.nixpkgs-lib.follows = "nixpkgs";
		};

		sops-nix = {
			url = "github:Mic92/sops-nix";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		easy-hosts.url = "github:isabelroses/easy-hosts";
		
		apple-fonts.url = "github:Lyndeno/apple-fonts.nix";

		nix-minecraft.url = "github:Infinidoge/nix-minecraft";
	};

	outputs =
		inputs:
		inputs.flake-parts.lib.mkFlake { inherit inputs; } {
			imports = [ ./systems ];
		};
}
