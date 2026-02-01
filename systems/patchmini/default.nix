{
  imports = [
    ./networking.nix
  ];

  flake.services = {
    openssh.enable = true;

    tailscale.enable = true;
  };
}
