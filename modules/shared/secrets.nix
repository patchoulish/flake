{
	sops = {
		age = {
			sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
		};

		defaultSopsFile = ../../secrets.yaml;

		# Secrets available at 'sops.secrets.*'.
		secrets.example = { };
	};
}
