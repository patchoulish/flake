{ lib, flake-parts-lib, ... }:
let
  inherit (flake-parts-lib) mkSubmoduleOptions;
in
{
  options = {
    flake = mkSubmoduleOptions {
      darwinModules = lib.mkOption {
        type = lib.types.lazyAttrsOf lib.types.unspecified;
        default = { };
        description = "nix-darwin modules";
      };

      homeManagerModules = lib.mkOption {
        type = lib.types.lazyAttrsOf lib.types.unspecified;
        default = { };
        description = "Home Manager modules";
      };

      wslModules = lib.mkOption {
        type = lib.types.lazyAttrsOf lib.types.unspecified;
        default = { };
        description = "WSL-specific modules";
      };
    };
  };
}
