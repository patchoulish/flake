{ lib, ... }:
let
  nixosModule =
    {
      lib,
      inputs,
      config,
      ...
    }:
    let
      cfg = config.flake.services.minecraft;
    in
    {
      # Define options for the module.
      options.flake.services.minecraft = {
        enable = lib.mkEnableOption "Minecraft server service";

        instances = lib.mkOption {
          type = lib.types.attrs;
          default = { };
        };
      };

      config = {
        nixpkgs.overlays = lib.mkIf cfg.enable [
          # Add the package overlay for nix-minecraft.
          # (enables pkgs.minecraftServers.*)
          inputs.nix-minecraft.overlay
        ];

        services.minecraft-servers = lib.mkIf cfg.enable {
          # Enable Minecraft server(s) via nix-minecraft.
          enable = true;

          eula = true;

          openFirewall = true;

          dataDir = "/var/lib/minecraft";

          managementSystem = {
            systemd-socket.enable = true;
          };

          # Pass the per-instance configuration to nix-minecraft.
          servers = cfg.instances;
        };
      };
    };
in
{
  config.flake = {
    # Export a NixOS module.
    nixosModules.minecraft-server = nixosModule;
  };
}
