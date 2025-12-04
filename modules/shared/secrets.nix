{
	sops = {
		age = {
			sshKeyPaths = [ "/etc/ssh/host_key" ];
		};

		defaultSopsFile = ../../secrets.yaml;

		# Secrets available at 'sops.secrets.*'.
		secrets.example = { };
	};
}
