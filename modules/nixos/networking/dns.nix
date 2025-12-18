{ lib, config, ... }:
let
	cfg = config.flake.system.dns;
in
{
	options = {
		flake.system.dns = {
			enable = lib.mkOption {
				type = lib.types.bool;
				default = true;
			};
		};
	};

	config = lib.mkIf cfg.enable {
		networking.nameservers = [
			# Use unbound as the system DNS resolver.
			"127.0.0.1"
		];

		services.unbound = {
			# Enable the unbound daemon.
			enable = true;

			settings = {
				forward-zone = [
					{
						name = ".";
						forward-addr = [
							"1.1.1.1@853#cloudflare-dns.com"
							"1.0.0.1@853#cloudflare-dns.com"
						];
						forward-ssl-upstream = "yes";
					}
				];
			};
		};
	};
}
