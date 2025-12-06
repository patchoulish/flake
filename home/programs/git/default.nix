{ lib, pkgs, ... }:
{
	programs.git = {
		# Enable git.
		enable = true;

		# Ignore Finder metadata files on macOS (Darwin).
		ignores = lib.mkIf pkgs.stdenv.isDarwin [
			".DS_Store"
		];

		settings = {
			core = {
				# The text editor to use.
				editor = "vscode";
			};

			user = {
				# The name and email to commit with.
				name = "patchoulish";
				email = "self@patchouli.sh";
			};

			# The default branch name to use.
			init.defaultBranch = "main";

			diff = {
				# For seeing secrets diffs in plaintext.
				sopsdiffer = {
					textconv = "sops decrypt";
				};
			};
		};

		signing = {
			# Sign commits using my SSH key.
			format = "ssh";
			key = "~/.ssh/id_ed25519.pub";
			signByDefault = true;
		};

		lfs = {
			# Enable LFS (large file support).
			enable = true;

			# Don't download large files automatically during clone/pull.
			# Use 'git lfs pull' to get them later.
			skipSmudge = true;
		};
	};
}
