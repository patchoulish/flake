{ self, ... }:
let
  nixosModule =
    { ... }:
    {
      networking = {
        firewall = {
          # Ensure the firewall is enabled.
          enable = true;
        };

        nftables = {
          # Use nftables instead of iptables.
          enable = true;
        };
      };
    };

  darwinModule =
    { ... }:
    {
      networking.dns = [
        # Cloudflare
        "1.1.1.1"
        "1.0.0.1"
      ];
    };
in
{
  flake = {
    # Export a NixOS module.
    nixosModules.networking = nixosModule;

    # Export a nix-darwin module.
    darwinModules.networking = darwinModule;
  };
}
