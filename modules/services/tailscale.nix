{ lib, ... }:
let
  nixosModule =
    { lib, config, ... }:
    let
      cfg = config.flake.services.tailscale;
    in
    {
      # Define options for the module.
      options.flake.services.tailscale = {
        enable = lib.mkEnableOption "tailscale service";
      };

      config = {
        services.tailscale = {
          # Enable tailscale.
          enable = lib.mkIf cfg.enable true;
        };
      };
    };

  darwinModule =
    { lib, config, ... }:
    let
      cfg = config.flake.services.tailscale;
    in
    {
      # Define options for the module.
      options.flake.services.tailscale = {
        enable = lib.mkEnableOption "tailscale service";
      };

      config = {
        services.tailscale = {
          # Enable tailscale.
          enable = lib.mkIf cfg.enable true;
        };
      };
    };
in
{
  config.flake = {
    # Export a NixOS module.
    nixosModules.tailscale = nixosModule;

    # Export a nix-darwin module.
    darwinModules.tailscale = darwinModule;
  };
}
