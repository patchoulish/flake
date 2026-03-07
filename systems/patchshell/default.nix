{
  imports = [
    ./networking.nix
    ./wsl.nix
  ];

  flake.services = {
    chrony.enable = true;

    openssh.enable = true;

    unbound.enable = true;

    tailscale.enable = true;
  };
}
