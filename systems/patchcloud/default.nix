{
  imports = [
    ./disk.nix
    ./hardware.nix
    ./networking.nix
  ];

  flake.services = {
    chrony.enable = true;

    openssh.enable = true;

    tailscale.enable = true;
  };

  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  time.timeZone = "America/Toronto";

  i18n.defaultLocale = "en_CA.UTF-8";
}
