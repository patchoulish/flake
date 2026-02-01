{ ... }:
let
  nixosOrDarwinModule =
    {
      self,
      self',
      inputs,
      inputs',
      ...
    }:
    {
      home-manager = {
        extraSpecialArgs = {
          inherit
            self
            self'
            inputs
            inputs'
            ;
        };

        useGlobalPkgs = true;
        useUserPackages = true;

        # The file extension to use when Home Manager overwrites an existing file.
        backupFileExtension = "backup";

        sharedModules = [
          # The configuration schema version for Home Manager.
          { home.stateVersion = "25.11"; }
        ];

        users.patchouli = {
          # We assume a single-user environment here.
          imports = builtins.attrValues self.homeManagerModules;
        };
      };
    };

  homeManagerModule =
    { ... }:
    {
      programs.home-manager = {
        # Whether to enable Home Manager. This should always be 'true'.
        enable = true;
      };
    };
in
{
  flake = {
    # Export a NixOS module.
    nixosModules.home-manager = nixosOrDarwinModule;

    # Export a nix-darwin module.
    darwinModules.home-manager = nixosOrDarwinModule;

    # Export a Home Manager module.
    homeManagerModules.home-manager = homeManagerModule;
  };
}
