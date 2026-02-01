{ lib, ... }:
{
  # Platform detection utilities for use in modules.
  # These functions check the system's configuration to determine the platform type.

  # Check if running on Darwin (macOS).
  isDarwin = { config, ... }: (config.networking.hostPlatform.isDarwin or false);

  # Check if running on Linux (includes both native Linux and WSL).
  isLinux = { config, ... }: (config.networking.hostPlatform.isLinux or false);

  # Check if running under WSL (Windows Subsystem for Linux).
  # This checks for the wsl.enable option which is set by the nixos-wsl module.
  isWSL = { config, ... }: (config.wsl.enable or false);
}
