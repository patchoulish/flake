{
  pkgs,
  config,
  inputs',
  ...
}:
{
  stylix = {
    # Enable stylix.
    enable = true;

    # The base16 scheme to use to theme the system.
    base16Scheme = "${pkgs.base16-schemes}/share/themes/caroline.yaml";

    fonts = {
      monospace = {
        package = inputs'.apple-fonts.packages.sf-mono-nerd;
        name = "SFMono";
      };
      serif = {
        package = inputs'.apple-fonts.packages.sf-pro;
        name = "SFProDisplay";
      };
      sansSerif = config.stylix.fonts.serif;
    };
  };
}
