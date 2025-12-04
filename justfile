flake := env('FLAKE', justfile_directory())

[private]
default:
	@just --list --unsorted

# Build a system configuration defined by the flake.
[linux]
build *args:
	sudo nixos-rebuild build --flake "{{flake}}" {{args}}

# Build a system configuration defined by the flake.
[macos]
build *args:
	sudo darwin-rebuild build --flake "{{flake}}" {{args}}

# Build and switch to a system configuration defined by the flake.
[linux]
switch *args:
	sudo nixos-rebuild switch --flake "{{flake}}" {{args}}

# Build and switch to a system configuration defined by the flake.
[macos]
switch *args:
	sudo darwin-rebuild switch --flake "{{flake}}" {{args}}

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
update:
	nix flake update

# Collect garbage and optimize the Nix store.
clean:
	sudo nix-collect-garbage --delete-older-than 3d
	sudo nix store optimise
