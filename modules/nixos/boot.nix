{ lib, pkgs, config, ... }:
let
	cfg = config.flake.system.boot;
in
{
	options.flake.system.boot = {
		silent = lib.mkOption {
			type = lib.types.bool;
			default = true;
			description = "Whether to boot quietly.";
		};
	};

	config = {
		boot = lib.mkIf cfg.silent {
			initrd.verbose = false;

			consoleLogLevel = 0;

			kernelParams = [ "quiet" "udev.log_level=3" ];
		};
	};
}
