{ lib, ... }:
{
  services.openssh = {
    # Enable OpenSSH.
    enable = true;

    extraConfig = lib.concatStringsSep "\n" [
      # See https://www.mankier.com/5/sshd_config

      # Don't allow login as root.
      "PermitRootLogin no"
      # Disable password authentication (use a key).
      "PasswordAuthentication no"
      # Verbose logging (needed for fail2ban sshd jail).
      "LogLevel VERBOSE"
    ];
  };
}
