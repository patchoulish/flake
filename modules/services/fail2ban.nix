{ lib, ... }:
let
  nixosModule =
    { lib, config, ... }:
    let
      cfg = config.flake.services.fail2ban;
    in
    {
      # Define options for the module.
      options.flake.services.fail2ban = {
        enable = lib.mkEnableOption "fail2ban service";
      };

      config = {
        services.fail2ban = {
          # Enable fail2ban.
          enable = lib.mkIf cfg.enable true;
        };
      };
    };
in
{
  config.flake = {
    # Export a NixOS module.
    nixosModules.fail2ban = nixosModule;
  };
}
