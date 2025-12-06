{
    imports = [
		./hardware.nix
		./networking.nix
	];

	boot.loader = {
		systemd-boot.enable = true;
		efi.canTouchEfiVariables = true;
	};

	time.timeZone = "America/Toronto";

	i18n.defaultLocale = "en_CA.UTF-8";

	# TODO: Is this even needed now?
	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};

	services.displayManager.gdm.enable = true;
	services.desktopManager.gnome.enable = true;

	programs.firefox.enable = true;
}
