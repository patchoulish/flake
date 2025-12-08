{ lib, pkgs, ... }:
{
    imports = [
		./hardware.nix
		./networking.nix
	];

	flake.system = {
		boot = {
			# Enable silent boot.
			silent = true;
		};

		services = {
			minecraft = {
				enable = true;

				instances = {
					vanilla = {
						enable = true;

						# Use the latest version of PaperMC for Minecraft 1.21.10.
						package = pkgs.minecraftServers.paper-1_21_10;

						# Aikar's suggested JVM flags.
						# See https://www.spigotmc.org/threads/guide-optimizing-spigot-remove-lag-fix-tps-improve-performance.21726/page-10#post-1055873
						jvmOpts = lib.concatStringsSep " " [
							"-Xms4G"
							"-Xmx4G"
							"-XX:+UseG1GC"
							"-XX:+UnlockExperimentalVMOptions"
							"-XX:MaxGCPauseMillis=50"
							"-XX:+DisableExplicitGC"
							"-XX:TargetSurvivorRatio=90"
							"-XX:G1NewSizePercent=50"
							"-XX:G1MaxNewSizePercent=80"
							"-XX:InitiatingHeapOccupancyPercent=10"
							"-XX:G1MixedGCLiveThresholdPercent=50"
						];

						serverProperties = {
							white-list = true;
							difficulty = "normal";
							motd = "Minecraft with fwends!";
						};
					};
				};
			};
		};
	};

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
