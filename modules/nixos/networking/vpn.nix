{ lib, config, ... }:
let
  cfg = config.flake.system.vpn;

  knownHosts = {
    patchbox = {
      ipv4 = "100.72.0.20";
    };
    patchcloud = {
      ipv4 = "100.72.0.30";
    };
    patchmini = {
      ipv4 = "100.72.0.40";
    };
    patchshell = {
      ipv4 = "100.72.0.50";
    };
  };
in
{
  # TODO:
  # Either harden tailscale and set up headscale,
  # or switch to nebula.

  options = {
    flake.system.vpn = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };

      dns = {
        authZone = lib.mkOption {
          type = lib.types.bool;
          default = true;
        };

        authZoneDomain = lib.mkOption {
          type = lib.types.str;
          default = "tail";
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    # Configuration for tailscale.
    services.tailscale = {
      # Enable tailscale.
      enable = true;
    };

    # Additional configuration for unbound.
    services.unbound = {
      settings = {
        auth-zone = lib.mkIf cfg.dns.authZone [
          {
            name = "${cfg.dns.authZoneDomain}.";
            zonefile = "/etc/unbound/zones/tailnet.zone";
          }
        ];
      };
    };

    environment.etc."unbound/zones/tailnet.zone".text = lib.mkIf cfg.dns.authZone ''
      $TTL 300
      @		IN SOA ns.${cfg.dns.authZoneDomain}. self.patchouli.sh. (
      		2025121704 ; serial
      		3600       ; refresh
      		1800       ; retry
      		604800     ; expire
      		300        ; minimum
      )
      @		IN NS	ns.${cfg.dns.authZoneDomain}.
      ns		IN A	127.0.0.1
      ${builtins.concatStringsSep "\n" (
        builtins.concatLists (
          lib.mapAttrsToList (
            host: attrs:
            builtins.filter (x: x != null) [
              "${host}\tIN A\t${attrs.ipv4}"
            ]
          ) knownHosts
        )
      )}'';
  };
}
