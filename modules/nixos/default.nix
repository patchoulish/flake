{ ... }:
{
  imports = [
    ./networking
    ./programs
    ./services
    ./boot.nix
    ./users.nix
  ];

  # The configuration schema version for NixOS.
  system.stateVersion = "25.11";
}
