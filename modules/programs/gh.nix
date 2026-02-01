{ ... }:
let
  homeManagerModule =
    { pkgs, ... }:
    {
      programs.gh = {
        # Enable GitHub CLI.
        enable = true;

        settings = {
          # Use SSH.
          git_protocol = "ssh";
        };

        # Configure the git credential helper
        # provided by the GitHub CLI.
        gitCredentialHelper = {
          enable = true;

          hosts = [
            "https://github.com"
            "https://gist.github.com"
          ];
        };

        # Use the following extensions.
        extensions = with pkgs; [
          gh-dash
        ];
      };
    };
in
{
  flake = {
    # Export a Home Manager module.
    homeManagerModules.gh = homeManagerModule;
  };
}
