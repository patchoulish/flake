{ lib, pkgs, config, ... }:
let
	cfg = config.flake.system.services.nebula;
in
{
	options = {
		flake.system.services.nebula = {
			enable = lib.mkOption {
				type = lib.types.bool;
				default = false;
			};

			port = lib.mkOption {
				type = lib.types.int;
				default = 4242;
			};

			isLighthouse = lib.mkOption {
				type = lib.types.bool;
				default = false;
			};
		};
	};

	config = {
		sops.secrets.nebula-cert = {
			path = "/etc/nebula/host.crt";
			sopsFile = ./../../../../secrets/${config.networking.hostName}.yaml;
		};

		sops.secrets.nebula-key = {
			path = "/etc/nebula/host.key";
			sopsFile = ./../../../../secrets/${config.networking.hostName}.yaml;
		};

		sops.secrets.nebula-ca = {
			path = "/etc/nebula/ca.crt";
			sopsFile = ./../../../../secrets/${config.networking.hostName}.yaml;
		};

		environment.systemPackages = with pkgs; [ nebula ];

		services.nebula.networks.patch = lib.mkIf cfg.enable {
			# Enable the patch network.
			enable = true;

			staticHostMap = {
				"10.72.2.8" = [
					"vpn.patchouli.sh:${builtins.toString cfg.port}"
				];
			};

			listen = {
				port = cfg.port;
				host = "0.0.0.0";
			};

			lighthouses = lib.mkIf (!cfg.isLighthouse) [
				"10.72.2.8"
			];

			isLighthouse = cfg.isLighthouse;

			firewall = {
				inbound = [
					{
						host = "any";
						port = "22";
						proto = "any";
					}
				];
				outbound = [
					{
						host = "any";
						port = "any";
						proto = "any";
					}
				];
			};

			cert = "/etc/nebula/host.crt";
			key = "/etc/nebula/host.key";
			ca = "/etc/nebula/ca.crt";
		};
	};
}
