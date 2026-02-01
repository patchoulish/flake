{ ... }:
let
  homeManagerModule =
    { pkgs, ... }:
    {
      home = {
        # Use XDG directories whenever supported.
        preferXdgDirectories = true;

        packages = with pkgs; [
          # Utilities.
          nix-output-monitor
          just
          nvd
          age
          sops

          hyprpicker

          # Temporary- use gh or something instead.
          github-desktop

          # For fun.
          kittysay
        ];
      };
    };
in
{
  flake = {
    # Export a Home Manager module.
    homeManagerModules.home = homeManagerModule;
  };
}
