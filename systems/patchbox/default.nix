{
    imports = [
		./hardware.nix
		./networking.nix
	];

	# Enable silent boot.
	flake.system.boot.silent = true;

	boot.loader = {
		systemd-boot.enable = true;
		efi.canTouchEfiVariables = true;
	};

	time.timeZone = "America/Toronto";

	i18n.defaultLocale = "en_CA.UTF-8";

	services.xserver = {
		xkb = {
			layout = "us";
			variant = "";
		};

		videoDrivers = [ "nvidia" ];
	};


	programs.firefox.enable = true;
}
