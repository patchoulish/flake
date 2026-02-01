{ ... }:
let
  nixosOrDarwinModule =
    { ... }:
    {
      programs.fish = {
        # Enable fish, the friendly interactive shell.
        enable = true;
      };
    };

  homeManagerModule =
    { ... }:
    {
      programs.fish = {
        # Enable fish, the friendly interactive shell.
        enable = true;
      };
    };
in
{
  flake = {
    # Export a NixOS module.
    nixosModules.shell = nixosOrDarwinModule;
    # Export a nix-darwin module.
    darwinModules.shell = nixosOrDarwinModule;
    # Export a Home Manager module.
    homeManagerModules.shell = homeManagerModule;
  };
}
