{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:
{
  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      gc = {
        # Automatically run the garbage collector on a set schedule.
        automatic = true;
        # Pass these options to the garbage collector when run automatically.
        options = "--delete-older-than 3d";
      };

      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];

        flake-registry = "";

        warn-dirty = false;

        trusted-users = [ "patchouli" ];

        # Workaround for https://github.com/NixOS/nix/issues/9574
        nix-path = config.nix.nixPath;
      };

      # Opinionated: disable channels
      channel.enable = false;

      # Opinionated: make flake registry and nix path match flake inputs
      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };
}
