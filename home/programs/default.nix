{ pkgs, ... }:
{
  imports = [
    ./bash
    ./chromium
    ./dotnet
    ./fish
    ./gh
    ./git
    ./home-manager
    ./hyfetch
    ./kitty
    ./obsidian
    ./starship
    ./vicinae
    ./vscode
  ];

  flake.home.programs.dotnet = {
    # Enable the .NET SDK.
    enable = true;

    # Use .NET 10.
    package = pkgs.dotnet-sdk_10;
  };
}
