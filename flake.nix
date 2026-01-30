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

    flake-compat = {
      url = "github:NixOS/flake-compat";
      flake = false;
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

      perSystem =
        { pkgs, ... }:
        {
          devShells.default = pkgs.mkShell {
            name = "flake-dev";

            packages = with pkgs; [
              # For development.
              nix-output-monitor
              nvd
              age
              sops

              # For source control.
              git

              # For command recipes.
              just

              # For pre-commit hooks.
              pre-commit

              # For formatting.
              treefmt
              nixfmt
              toml-sort
              yamlfmt
              mdformat
            ];

            shellHook = ''
              echo "Setting up Git hooks..."
              pre-commit install
              echo "Git hooks installed."
              echo ""
              echo "Welcome to the flake development shell."
              echo "Run 'just' to see available recipes."
            '';
          };
        };
    };
}
