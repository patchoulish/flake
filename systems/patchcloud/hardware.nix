{ lib, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot = {
    initrd = {
      availableKernelModules = [
        "ata_piix"
        "uhci_hcd"
        "virtio_pci"
        "virtio_blk"
      ];

      kernelModules = [
        "dm-snapshot"
      ];
    };

    kernelModules = [ "kvm-intel" ];

    extraModulePackages = [ ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/mapper/pool-root";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/F631-55CE";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };
  };

  swapDevices = [ ];
}
