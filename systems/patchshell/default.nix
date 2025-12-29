{
  imports = [
    ./networking.nix
    ./wsl.nix
  ];

  flake.system = {
    services = {
      chrony = {
        enable = true;
      };

      nebula = {
        enable = true;
      };
    };
  };
}
