{ lib, ... }:
let
  nixosModule =
    { lib, config, ... }:
    let
      cfg = config.flake.boot;
    in
    {
      options.flake.boot = {
        silent = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Whether to boot quietly.";
        };
      };

      config.boot = lib.mkIf cfg.silent {
        initrd.verbose = false;

        consoleLogLevel = 0;

        kernelParams = [
          "quiet"
          "udev.log_level=3"
        ];
      };
    };
in
{
  config.flake = {
    # Export a NixOS module.
    nixosModules.boot = nixosModule;
  };
}
