{ lib, ... }:
let
  nixosModule =
    { lib, config, ... }:
    let
      cfg = config.flake.services.openssh;
    in
    {
      # Define options for the module.
      options.flake.services.openssh = {
        enable = lib.mkEnableOption "openssh service";
      };

      config = {
        services.openssh = {
          # Enable OpenSSH.
          enable = lib.mkIf cfg.enable true;

          settings = {
            # Don't allow login as root.
            PermitRootLogin = "no";
            # Disable password authentication (use a key).
            PasswordAuthentication = false;
            # Verbose logging (needed for fail2ban sshd jail).
            LogLevel = "VERBOSE";
          };
        };
      };
    };

  darwinModule =
    { lib, config, ... }:
    let
      cfg = config.flake.services.openssh;
    in
    {
      # Define options for the module.
      options.flake.services.openssh = {
        enable = lib.mkEnableOption "openssh service";
      };

      config = {
        services.openssh = {
          # Enable OpenSSH.
          enable = lib.mkIf cfg.enable true;

          extraConfig = lib.concatStringsSep "\n" [
            # See https://www.mankier.com/5/sshd_config

            # Don't allow login as root.
            "PermitRootLogin no"
            # Disable password authentication (use a key).
            "PasswordAuthentication no"
            # Verbose logging.
            "LogLevel VERBOSE"
          ];
        };
      };
    };
in
{
  config.flake = {
    # Export a NixOS module.
    nixosModules.openssh = nixosModule;

    # Export a nix-darwin module.
    darwinModules.openssh = darwinModule;
  };
}
