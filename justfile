flake := env('FLAKE', justfile_directory())

cmd_rebuild := if os() == "macos" { "sudo darwin-rebuild" } else { "sudo nixos-rebuild" }
cmd_rebuild_args := if os() == "macos" { "" } else { "--log-format internal-json -v" }
cmd_nom := if os() == "macos" { "nom" } else { "sudo nom --json" }
cmd_nvd := "nvd diff"

cmd_redeploy := "nix run github:nix-community/nixos-anywhere --"

[private]
default:
	@just --list --unsorted

# Build a system configuration defined by the flake.
[group('rebuild')]
@build *args:
	{{ cmd_rebuild }} build --flake "{{flake}}" {{cmd_rebuild_args}} {{args}} |& {{ cmd_nom }}
	{{ cmd_nvd }} /run/current-system ./result

# Build and switch to a system configuration defined by the flake.
[group('rebuild')]
@switch *args:
	# On NixOS, build once to ./result so nvd can diff before activating that exact closure.
	if [ "{{ os() }}" = "macos" ]; then \
		{{ cmd_rebuild }} switch --flake "{{flake}}" {{cmd_rebuild_args}} {{args}} |& {{ cmd_nom }}; \
	else \
		{{ cmd_rebuild }} build --flake "{{flake}}" {{cmd_rebuild_args}} {{args}} |& {{ cmd_nom }}; \
		{{ cmd_nvd }} /run/current-system ./result; \
		sudo ./result/bin/switch-to-configuration switch; \
	fi

[private]
[group('redeploy')]
redeploy system via *args:
	{{ cmd_redeploy }} --flake "{{ flake }}#{{ system }}" --copy-host-keys {{ args }} {{ via }}

# Usage: 'just deploy patchcloud <username>@<ip addr>'
# Usage: 'just deploy patchcloud <username>@<ip addr> --generate-hardware-config nixos-generate-config ./systems/patchcloud/hardware.nix'

# Deploy a system configuration defined by the flake to a remote host.
[group('redeploy')]
deploy system via *args: (redeploy system via args)

# List secrets.
[group('secrets')]
list-secrets:
	sops decrypt secrets.yaml

# Add or remove secrets.
[group('secrets')]
update-secrets:
	sops secrets.yaml

# Update the secret keys used to encrypt secrets.
[group('secrets')]
update-secret-keys:
	sops updatekeys -y secrets.yaml

# Update the inputs to the flake.
[group('util')]
update:
	nix flake update

# Format the repository.
[group('util')]
format:
	treefmt

# Check the formatting for the repository.
[group('util')]
format-check:
	treefmt --fail-on-change --no-cache

# Collect garbage and optimize the Nix store.
[group('util')]
clean:
	sudo nix-collect-garbage --delete-older-than 3d
	sudo nix store optimise
