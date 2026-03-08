{ ... }:
let
  homeManagerModule =
    { ... }:
    {
      programs.vscode = {
        # Enable Visual Studio Code.
        enable = true;
      };

      # Ensure Home Manager activation doesn't hang on
      # Visual Studio Code's install recommendation prompt.
      home.sessionVariables.DONT_PROMPT_WSL_INSTALL = "1";
    };
in
{
  flake = {
    # Export a Home Manager module.
    homeManagerModules.vscode = homeManagerModule;
  };
}
