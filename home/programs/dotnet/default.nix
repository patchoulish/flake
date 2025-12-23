{ lib, pkgs, config, ... }:
let
	cfg = config.flake.home.programs.dotnet;
in
{
	options = {
		flake.home.programs.dotnet = {
			enable = lib.mkEnableOption "the .NET SDK";

			package = lib.mkPackageOption pkgs "the .NET SDK" {
				default = [ "dotnet-sdk" ];
			};

			rollForward = lib.mkOption {
				type = lib.types.enum [ "Minor" "Major" "LatestPatch" "LatestMinor" "LatestMajor" "Disable" ];
				default = "Minor";
			};

			rollForwardToPreRelease = lib.mkOption {
				type = lib.types.bool;
				default = false;
			};
		};
	};

	config = lib.mkIf cfg.enable {
		home.packages = [
				cfg.package
			];
		
		home.sessionVariables = {
			DOTNET_NOLOGO = "1";

			DOTNET_CLI_HOME = "${config.xdg.stateHome}/dotnet";
			DOTNET_CLI_TELEMETRY_OPTOUT = "1";

			DOTNET_ROLL_FORWARD = "${cfg.rollForward}";
			DOTNET_ROLL_FORWARD_TO_PRERELEASE =
				if cfg.rollForwardToPreRelease then "1" else "0";

			NUGET_PACKAGES = "${config.xdg.cacheHome}/nuget/packages";
			NUGET_HTTP_CACHE_PATH = "${config.xdg.cacheHome}/nuget/http-cache";
			NUGET_PLUGINS_CACHE_PATH = "${config.xdg.cacheHome}/nuget/plugins-cache";
		};

		home.activation.dotnetDirs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
			mkdir -p \
				"${config.xdg.stateHome}/dotnet" \
				"${config.xdg.cacheHome}/nuget/packages" \
				"${config.xdg.cacheHome}/nuget/http-cache" \
				"${config.xdg.cacheHome}/nuget/plugins-cache"
		'';

		xdg.configFile."NuGet/NuGet.Config".text = ''
			<?xml version="1.0" encoding="utf-8"?>

			<configuration>
				<packageSources>
					<add key="nuget.org" value="https://api.nuget.org/v3/index.json" />
				</packageSources>

				<config>
					<add key="globalPackagesFolder" value="${config.xdg.cacheHome}/nuget/packages" />
					<add key="dependencyVersion" value="Highest" />
				</config>
			</configuration>
		'';
	};
}
