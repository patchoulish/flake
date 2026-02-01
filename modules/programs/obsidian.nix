{ ... }:
let
  homeManagerModule =
    { ... }:
    {
      programs.obsidian = {
        # Enable Obsidian.
        enable = true;
      };
    };
in
{
  flake = {
    # Export a Home Manager module.
    homeManagerModules.obsidian = homeManagerModule;
  };
}
