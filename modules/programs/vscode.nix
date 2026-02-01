{ ... }:
let
  homeManagerModule =
    { ... }:
    {
      programs.vscode = {
        # Enable Visual Studio Code.
        enable = true;
      };
    };
in
{
  flake = {
    # Export a Home Manager module.
    homeManagerModules.vscode = homeManagerModule;
  };
}
