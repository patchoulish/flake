{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShell {
  name = "flake-dev";

  packages = with pkgs; [
    # For development.
    nix-output-monitor
    nvd
    age
    sops

    # For source control.
    git

    # For command recipes.
    just

    # For pre-commit hooks.
    pre-commit

    # For formatting.
    treefmt
    nixfmt-rfc-style
    toml-sort
    yamlfmt
    mdformat
  ];

  shellHook = ''
    echo "Setting up Git hooks..."
    if [ -f .git/hooks/pre-commit ]; then
      echo "Git hooks already installed."
    else
      pre-commit install
      echo "Git hooks installed."
    fi
    echo ""
    echo "Welcome to the flake development shell."
    echo "Run 'just' to see available recipes."
  '';
}
