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
}
