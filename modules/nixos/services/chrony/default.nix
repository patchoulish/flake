{ lib, pkgs, config, ... }:
let
	cfg = config.flake.system.services.chrony;
in
{
	options = {
		flake.system.services.chrony = {
			enable = lib.mkEnableOption "NTP services";

			upstream = lib.mkOption {
				type = lib.types.listOf lib.types.str;
				default = [
					"time.cloudflare.com"
				];
			};
		};
	};

	config = lib.mkIf cfg.enable {
		networking = {
			# The set of NTP servers from which to synchronise.
			timeServers = cfg.upstream;
		};

		services.chrony = {
			# Whether to synchronise time using chrony.
			enable = true;
			# The set of NTP servers from which to synchronise.
			servers = cfg.upstream;
			# Whether to enable Network Time Security authentication.
			enableNTS = true;
			# Whether to prevent chrony from being paged out.
			enableMemoryLocking = true;
		};
	};
}
