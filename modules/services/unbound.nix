{ lib, ... }:
let
  nixosModule =
    { lib, config, ... }:
    let
      cfg = config.flake.services.unbound;

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
      # Define options for the module.
      options.flake.services.unbound = {
        enable = lib.mkEnableOption "unbound service";

        tailscale = {
          authZone = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Whether to add a DNS auth zone for the Tailscale tailnet.";
          };

          authZoneDomain = lib.mkOption {
            type = lib.types.str;
            default = "tail";
            description = "The domain name for the Tailscale tailnet DNS auth zone.";
          };
        };
      };

      config = {
        services.unbound = {
          # Enable unbound.
          enable = lib.mkIf cfg.enable true;

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

            auth-zone = lib.mkIf cfg.tailscale.authZone [
              {
                name = "${cfg.tailscale.authZoneDomain}.";
                zonefile = "/etc/unbound/zones/tailnet.zone";
              }
            ];
          };
        };

        networking.nameservers = lib.mkIf cfg.enable [
          # Use unbound as the system DNS resolver.
          "127.0.0.1"
        ];

        environment.etc."unbound/zones/tailnet.zone" = lib.mkIf (cfg.enable && cfg.tailscale.authZone) {
          text = ''
            $TTL 300
            @		IN SOA ns.${cfg.tailscale.authZoneDomain}. self.patchouli.sh. (
            		2025121704 ; serial
            		3600       ; refresh
            		1800       ; retry
            		604800     ; expire
            		300        ; minimum
            )
            @		IN NS	ns.${cfg.tailscale.authZoneDomain}.
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
      };
    };
in
{
  config.flake = {
    # Export a NixOS module.
    nixosModules.unbound = nixosModule;
  };
}
