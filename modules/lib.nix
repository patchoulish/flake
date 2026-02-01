{ lib, ... }:
{
  flake = {
    # Export custom library functions for use in modules.
    lib = import ../lib { inherit lib; };
  };
}
