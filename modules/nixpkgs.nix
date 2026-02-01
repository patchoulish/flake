{ ... }:
let
  nixosOrDarwinModule =
    { ... }:
    {
      # Allow unfree packages.
      nixpkgs.config.allowUnfree = true;
    };
in
{
  flake = {
    # Export a NixOS module.
    nixosModules.nixpkgs = nixosOrDarwinModule;
    # Export a nix-darwin module.
    darwinModules.nixpkgs = nixosOrDarwinModule;
  };
}
