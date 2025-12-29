{ pkgs, ... }:
{
  programs.chromium = {
    # Enable Chromium.
    enable = true;

    # Use the un-Googled version of Chromium.
    package = pkgs.ungoogled-chromium;

    # The list of extensions to install.
    extensions = [
      {
        # uBlock Origin.
        id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
      }
    ];

    # The list of dictionaries to install.
    dictionaries = with pkgs; [
      # English (US).
      hunspellDictsChromium.en-us
    ];
  };
}
