{ lib, ... }:
let
  nixosModule =
    { lib, config, ... }:
    let
      cfg = config.flake.services.chrony;
    in
    {
      # Define options for the module.
      options.flake.services.chrony = {
        enable = lib.mkEnableOption "chrony service";

        upstream = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [
            "time.cloudflare.com"
          ];
        };
      };

      config = {
        services.chrony = {
          # Enable chrony.
          enable = lib.mkIf cfg.enable true;
          # The set of NTP servers from which to synchronise.
          servers = cfg.upstream;
          # Whether to enable Network Time Security authentication.
          enableNTS = true;
          # Whether to prevent chrony from being paged out.
          enableMemoryLocking = true;
        };

        networking = lib.mkIf cfg.enable {
          # The set of NTP servers from which to synchronise.
          timeServers = cfg.upstream;
        };
      };
    };
in
{
  config.flake = {
    # Export a NixOS module.
    nixosModules.chrony = nixosModule;
  };
}
