{ ... }:
let
  homeManagerModule =
    { ... }:
    {
      programs.hyfetch = {
        # Enable Hyfetch.
        enable = true;

        settings = {
          # TODO: Set these based on stylix theme.
          preset = "solian";
          mode = "rgb";
          light_dark = "dark";
          lightness = 0.57;
          color_align = {
            mode = "horizontal";
          };
          backend = "neofetch";
          pride_month_disable = false;
        };
      };
    };
in
{
  flake = {
    # Export a Home Manager module.
    homeManagerModules.hyfetch = homeManagerModule;
  };
}
