{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:
let
  cfg = config.flake.system.services.minecraft;
in
{
  options.flake.system.services.minecraft = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    instances = lib.mkOption {
      type = lib.types.attrs;
      default = { };
    };
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.overlays = [
      # Add the package overlay for nix-minecraft.
      # (enables pkgs.minecraftServers.*)
      inputs.nix-minecraft.overlay
    ];

    services.minecraft-servers = {
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
}
