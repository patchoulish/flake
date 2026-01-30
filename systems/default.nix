{
  lib,
  self,
  inputs,
  ...
}:
let
  additionalClasses = {
    # WSL systems derive from NixOS ones.
    wsl = "nixos";
    # VM systems derive from NixOS ones.
    vm = "nixos";
  };

  # Canonicalizes a class i.e. WSL -> NixOS, NixOS -> NixOS.
  canonicalizeClass = class: additionalClasses.${class} or class;
in
{
  imports = [ inputs.easy-hosts.flakeModule ];

  # The system target(s) the flake supports. See 'hosts' below.
  systems = [
    # For x86: NixOS, WSL, macOS (Darwin) via Rosetta.
    "x86_64-linux"
    "x86_64-darwin"
    # For ARM64: NixOS, macOS (Darwin).
    "aarch64-linux"
    "aarch64-darwin"
  ];

  easy-hosts = {
    # The flake module(s) to share across all systems.
    shared.modules = [
      ../modules/shared
    ];

    # The additional system classes to use.
    inherit additionalClasses;

    # Per-system class configuration.
    perClass =
      class:
      let
        canonicalClass = canonicalizeClass class;
      in
      {
        modules = builtins.concatLists [
          [
            # Include the flake module for the system's canonical class i.e. NixOS.
            "${self}/modules/${canonicalClass}"
          ]

          (lib.optionals (class != canonicalClass) [
            # Include the module for the system's class i.e. WSL.
            "${self}/modules/${class}"
          ])

          (lib.optionals (canonicalClass == "nixos") [
            # Include input module(s) required for NixOS.
            inputs.home-manager.nixosModules.home-manager
            inputs.stylix.nixosModules.stylix
            inputs.sops-nix.nixosModules.sops
            inputs.nix-minecraft.nixosModules.minecraft-servers
          ])

          (lib.optionals (canonicalClass == "darwin") [
            # Include input module(s) required for macOS (Darwin).
            inputs.home-manager.darwinModules.home-manager
            inputs.stylix.darwinModules.stylix
            inputs.sops-nix.darwinModules.sops
          ])

          (lib.optionals (class == "wsl") [
            # Include input module(s) required for WSL.
            inputs.nixos-wsl.nixosModules.default
          ])

          (lib.optionals (class == "vm") [
            # Include input module(s) required for VM(s).
            inputs.disko.nixosModules.disko
          ])
        ];
      };

    # The system(s) output by the flake.
    hosts = {
      patchbox = {
        arch = "x86_64";
        class = "nixos";
      };
      patchcloud = {
        arch = "x86_64";
        class = "vm";
      };
      patchmini = {
        arch = "aarch64";
        class = "darwin";
      };
      patchshell = {
        arch = "x86_64";
        class = "wsl";
      };
    };
  };
}
