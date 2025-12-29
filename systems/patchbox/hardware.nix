{
  lib,
  pkgs,
  config,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "usb_storage"
        "usbhid"
        "sd_mod"
      ];

      kernelModules = [ ];
    };

    kernelModules = [ "kvm-intel" ];

    extraModulePackages = [ ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/81b8632b-b561-41f2-9246-1bf24268ac00";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/0C3C-A780";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };
  };

  swapDevices = [ ];

  hardware = {
    # Enable firmware with a license allowing redistribution.
    enableRedistributableFirmware = true;

    cpu = {
      intel = {
        # Update the CPU microcode for the Intel processor.
        updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
      };
    };

    graphics = {
      # Enable hardware-accelerated graphics.
      enable = true;
    };

    nvidia = {
      # Use the latest stable package.
      package = config.boot.kernelPackages.nvidiaPackages.stable;

      # Use the open-source kernel module as the GTX 1660 Ti is supported.
      open = true;

      # Disable nvidia-settings.
      nvidiaSettings = false;
    };
  };
}
