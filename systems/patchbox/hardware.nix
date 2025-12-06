{ lib, pkgs, config, modulesPath, ... }:
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

	hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}