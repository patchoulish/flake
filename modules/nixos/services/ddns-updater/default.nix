{ lib, pkgs, config, ... }:
let
	cfg = config.flake.system.services.ddns-updater;
in
{
	options = {
		flake.system.services.ddns-updater = {
			enable = lib.mkEnableOption "Dynamic DNS Updater Service";

			package = lib.mkPackageOption pkgs "ddns-updater" { };

			# TODO: Add configuration options.
		};
	};

	config = lib.mkIf cfg.enable {
		sops.secrets.ddns-updater-provider = { };
		sops.secrets.ddns-updater-domain = { };
		sops.secrets.ddns-updater-password = { };

		sops.templates."ddns-updater-config.json" = {
			path = "/etc/ddns-updater/config.json";
			content = ''
				{
					"settings": [
						{
							"provider": "${config.sops.placeholder.ddns-updater-provider}",
							"domain": "${config.sops.placeholder.ddns-updater-domain}",
							"password": "${config.sops.placeholder.ddns-updater-password}"
						}
					]
				}
			'';
		};

		systemd.services.ddns-updater = {
			wantedBy = [ "multi-user.target" ];
			wants = [ "network-online.target" ];
			after = [ "network-online.target" ];

			environment = {
				"CONFIG_FILEPATH" = "${config.sops.templates."ddns-updater-config.json".path}";
				"DATADIR" = "%S/ddns-updater";
				"SERVER_ENABLED" = "no";
				"PERIOD" = "5m";
				"UPDATE_COOLDOWN_PERIOD" = "1h"; # Really, this could be *days*...
			};

			unitConfig = {
				Description = "Dynamic DNS Updater Service (ddns-updater)";
			};

			serviceConfig = {
				TimeoutSec = 240;
				ExecStart = lib.getExe cfg.package;
				RestartSec = 30;
				DynamicUser = true;
				StateDirectory = "ddns-updater";
				Restart = "on-failure";
			};
		};
	};
}
