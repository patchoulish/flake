{
	programs.git = {
		# Enable git.
		enable = true;

		settings = {
			user = {
				# The name and email to commit with.
				name = "patchoulish";
				email = "self@patchouli.sh";
			};

			# The default branch name to use.
			init.defaultBranch = "main";
		};
	};
}
