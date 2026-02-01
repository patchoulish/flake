{ ... }:
let
  homeManagerModule =
    {
      lib,
      self,
      config,
      ...
    }:
    {
      programs.kitty = {
        # Enable kitty.
        enable = true;

        font = {
          name = lib.mkForce "SFMono";

          # This does NOT spark joy.
          size = if (self.lib.isDarwin { inherit config; }) then lib.mkForce 14 else lib.mkForce 10;
        };

        settings = {
          # Pad the window a bit.
          window_padding_width = 8;
        };
      };
    };
in
{
  flake = {
    # Export a Home Manager module.
    homeManagerModules.kitty = homeManagerModule;
  };
}
