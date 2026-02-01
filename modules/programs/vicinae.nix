{ ... }:
let
  homeManagerModule =
    { ... }:
    {
      programs.vicinae = {
        # Enable Vicinae.
        enable = true;

        systemd = {
          enable = true;
        };
      };
    };
in
{
  flake = {
    # Export a Home Manager module.
    homeManagerModules.vicinae = homeManagerModule;
  };
}
