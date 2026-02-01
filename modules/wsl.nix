{ ... }:
let
  wslModule =
    { ... }:
    {
      wsl = {
        # Enable support for running NixOS as a WSL distribution.
        enable = true;

        # The name for the default uer.
        defaultUser = "patchouli";

        # Enable shortcuts for graphical applications in the Windows start menu.
        startMenuLaunchers = true;

        interop = {
          # Exclude Windows PATH from WSL PATH.
          includePath = false;
          # Explicitly register the binfmt_misc handler for Windows executables.
          register = true;
        };

        wslConf = {
          network = {
            # Not needed- we use unbound.
            generateResolvConf = false;
          };
        };
      };

      networking.firewall = {
        # Disable reverse path filter tests on packets as the required kernel support doesn't exist on Windows (WSL).
        checkReversePath = false;
      };
    };
in
{
  flake = {
    # Export a WSL module.
    wslModules.wsl = wslModule;
  };
}
