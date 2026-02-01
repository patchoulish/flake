{ ... }:
let
  nixosModule =
    { ... }:
    {
      programs.hyprland = {
        # Enable Hyprland.
        enable = true;
      };
    };
in
{
  flake = {
    # Export a NixOS module.
    nixosModules.hyprland = nixosModule;
  };
}
