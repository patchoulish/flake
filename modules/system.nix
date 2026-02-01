{ ... }:
let
  nixosModule =
    { ... }:
    {
      # The configuration schema version for NixOS.
      system.stateVersion = "25.11";
    };

  darwinModule =
    { ... }:
    {
      # The configuration schema version for nix-darwin.
      system.stateVersion = 6;
    };
in
{
  flake = {
    # Export a NixOS module.
    nixosModules.system = nixosModule;

    # Export a nix-darwin module.
    darwinModules.system = darwinModule;
  };
}
