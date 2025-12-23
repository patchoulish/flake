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
			chrony = {
				enable = true;
			};

			ddns-updater = {
				enable = true;
			};

			minecraft = {
				enable = true;

				instances = {
					modded = 
					let
						modpack = pkgs.fetchPackwizModpack {
							url = "https://raw.githubusercontent.com/patchoulish/minecraft-modpack/1.2.0/pack.toml";
							packHash = "sha256-mAX8Po8IoW/3JuGaiRGP/wxhYVyyFTJtz6C9XY2ihJA=";
						};
					in
					{
						enable = true;

						# Use the latest version of Fabric for Minecraft 1.20.1.
						package = pkgs.minecraftServers.fabric-1_20_1;

						symlinks = {
							"mods" = "${modpack}/mods";
						};

						# Aikar's suggested JVM flags.
						# See https://www.spigotmc.org/threads/guide-optimizing-spigot-remove-lag-fix-tps-improve-performance.21726/page-10#post-1055873
						jvmOpts = lib.concatStringsSep " " [
							"-Xms6G"
							"-Xmx6G"
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
							allow-flight = true;
							difficulty = "normal";
							enforce-whitelist = true;
							max-players = 16;
							max-world-size = 4096;
							motd = "Modded Minecraft with fwends!";
							op-permission-level = 2;
							snooper-enabled = false;
							spawn-protection = 0;
							white-list = true;
						};

						operators = {
							"marxxengelsbl" = {
								uuid = "2d56b3aa-2fb3-45ea-9029-627595630f90";
								level = 4;
								bypassesPlayerLimit = true;
							};
						};
					};
				};
			};
			
			nebula = {
				enable = true;
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
