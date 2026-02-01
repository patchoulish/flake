{ ... }:
let
  nixosModule =
    { pkgs, ... }:
    {
      users.users =
        let
          # The hashed password to use for each user account.
          # Generated with 'mkpasswd'.
          hashedPassword = "$y$j9T$hOvZcQOKuiVpM3ASU/CGX.$bAjaUfdOkNeAfcyWKOL3UgoeP86Er95GBYDaphTwuLB";
        in
        {
          patchouli = {
            # Do NOT change this.
            isNormalUser = true;

            # The login shell to use.
            # Fish may be problematic for this purpose, but it sure does look pretty.
            shell = pkgs.fish;

            home = "/home/patchouli";
            extraGroups = [ "wheel" ];

            openssh.authorizedKeys.keys = [
              "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII7LfwXAVJrM1KSxVcu5vmlcJBGXarW5YjavgqkCkQJX self@patchouli.sh"
            ];

            inherit hashedPassword;
          };

          root = {
            inherit hashedPassword;
          };
        };
    };

  darwinModule =
    { pkgs, ... }:
    {
      system = {
        # The name for the primary user.
        # NOTE: This is a transient option and will be removed at some point.
        primaryUser = "patchouli";
      };

      users.users = {
        patchouli = {
          name = "patchouli";

          # The login shell to use.
          # Fish may be problematic for this purpose, but it sure does look pretty.
          shell = pkgs.fish;

          home = "/Users/patchouli";
        };
      };
    };
in
{
  flake = {
    # Export a NixOS module.
    nixosModules.users = nixosModule;

    # Export a nix-darwin module.
    darwinModules.users = darwinModule;
  };
}
