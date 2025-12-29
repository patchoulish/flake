<div align="center">
	<img src=".github/assets/nix.svg" width="128" />
	<h1>flake</h1>
	<a href="https://builtwithnix.org">
		<img src="https://img.shields.io/badge/built_with_nix-blue?style=for-the-badge&logo=nixos&logoColor=white" />
	</a>
</div>

&#160;

:construction: Declarative system configurations for my NixOS, macOS (Darwin), and Windows (WSL) machines. :construction:

## Systems

The following systems are managed via this flake:

| Host | OS | Arch | Description |
|------------|----------------|---------|--------------------------------------------------------------|
| patchberry | NixOS | aarch64 | An ancient Raspberry Pi Model B. |
| patchbox | NixOS | x86_64 | A personal server for myself and friends. |
| patchcloud | NixOS (VM) | x86_64 | A VPS for tailscale egress/ingress, reverse-DNS, etc. |
| patchmini | macOS (Darwin) | aarch64 | A spare M1 Mac Mini I have lying around to tinker with. |
| patchshell | Windows (WSL) | x86_64 | A NixOS install running under Windows on my primary desktop. |

## Installation

The installation for a given system configuration varies depending on the underlying operating system.

### Windows (WSL)

1. Enable WSL if you haven't done so already.

```powershell
wsl --install --no-distribution
```

2. Download the latest release of `nixos.wsl` from the [NixOS-WSL](https://github.com/nix-community/NixOS-WSL) repository [here](https://github.com/nix-community/NixOS-WSL/releases/latest).
1. Double-click `nixos.wsl` (requires WSL >= 2.4.4).
1. Run NixOS under WSL.

```powershell
wsl -d NixOS
```

5. Clone the repository (in NixOS) and navigate to its root.
1. Ensure secret management is configured correctly. See [here](https://michael.stapelberg.ch/posts/2025-08-24-secret-management-with-sops-nix/) for details.
1. Build the system configuration of your choosing and switch.

```bash
sudo nixos-rebuild switch --flake .#<system>
```

8. Done! See [Usage](#usage) for details.

### macOS (Darwin)

1. Download and install Nix using the [Nix installer from Determinate Systems](https://github.com/DeterminateSystems/nix-installer). Upstream Nix is strongly recommended.

```zsh
curl -fsSL https://install.determinate.systems/nix | sh -s -- install --prefer-upstream-nix
```

2. Install Rosetta if you haven't done so already and restart the Nix daemon.

```zsh
sudo /usr/sbin/softwareupdate --install-rosetta && launchctl stop org.nixos.nix-daemon
```

3. Clone the repository and navigate to its root.
1. Ensure secret management is configured correctly. See [here](https://michael.stapelberg.ch/posts/2025-08-24-secret-management-with-sops-nix/) for details.
1. Build the system configuration of your choosing and switch. This will simultaneously install nix-darwin.

```zsh
sudo nix run nix-darwin/nix-darwin-25.11#darwin-rebuild -- switch --flake .#<system>
```

6. Done! See [Usage](#usage) for details.

## Usage

Using this flake once a system is up is simple. Run `just` from the repository root for a list of commands.
If you don't have a system up (for whatever reason), run `nix-shell` to enter a development shell and then run `just`.

## Acknowledgements

Special thanks to these repositories and their owners/contributors for inspiration:

- [isabelroses/dotfiles](https://github.com/isabelroses/dotfiles)
- [Misterio77/nix-config](https://github.com/Misterio77/nix-config)
- [uncenter/flake](https://github.com/uncenter/flake)
- *and others.*

As well as a few blog posts and articles, such as:

- [Secret Management on NixOS with sops-nix](https://michael.stapelberg.ch/posts/2025-08-24-secret-management-with-sops-nix/) by Michael Stapelberg
- *and others.*

## License

This flake is licensed under the MIT license. See `LICENSE` for full details.
