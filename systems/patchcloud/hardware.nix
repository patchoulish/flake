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

  swapDevices = [ ];
}
