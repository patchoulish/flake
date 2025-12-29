{ lib, pkgs, ... }:
{
  config = {
    programs.kitty = {
      # Enable kitty.
      enable = true;

      font = {
        name = lib.mkForce "SFMono";

        # This does NOT spark joy.
        size = if pkgs.stdenv.hostPlatform.isDarwin then lib.mkForce 14 else lib.mkForce 10;
      };

      settings = {
        # Pad the window a bit.
        window_padding_width = 8;
      };
    };
  };
}
