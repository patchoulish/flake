{ ... }:
let
  homeManagerModule =
    { ... }:
    {
      programs.bash = {
        # Enable the Bourne Again SHell.
        enable = true;
      };
    };
in
{
  flake = {
    # Export a Home Manager module.
    homeManagerModules.bash = homeManagerModule;
  };
}
