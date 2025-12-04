{
	services.openssh = {
		# Enable OpenSSH.
		enable = true;

		settings = {
			# Don't allow login as root.
			PermitRootLogin = "no";
			# Disable password authentication (use a key).
			PasswordAuthentication = false;
			# Verbose logging (needed for fail2ban sshd jail).
			LogLevel = "VERBOSE";
		};
	};
}
