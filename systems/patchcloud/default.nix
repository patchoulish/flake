{
	imports = [
		./disk.nix
		./hardware.nix
		./networking.nix
	];

	boot.loader.grub = {
		efiSupport = true;
		efiInstallAsRemovable = true;
	};

	time.timeZone = "America/Toronto";

	i18n.defaultLocale = "en_CA.UTF-8";
}
