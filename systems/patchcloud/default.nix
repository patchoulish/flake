{
	imports = [
		./disk.nix
		./hardware.nix
		./networking.nix
	];

	flake.system = {
		services = {
			chrony = {
				enable = true;
			};

			nebula = {
				enable = true;
				isLighthouse = true;
			};
		};
	};

	boot.loader.grub = {
		efiSupport = true;
		efiInstallAsRemovable = true;
	};

	time.timeZone = "America/Toronto";

	i18n.defaultLocale = "en_CA.UTF-8";
}
