{
  imports = [
    ./networking.nix
    ./wsl.nix
  ];

  flake.services = {
    chrony.enable = true;

    openssh.enable = true;

    tailscale.enable = true;
  };
}
