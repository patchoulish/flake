{
	imports = [
		./firewall.nix
	];

	networking.nameservers = [
		# Cloudflare
		"1.1.1.1"
		"1.0.0.0"
		# Cloudflare (block malware)
		# "1.1.1.2"
		# "1.0.0.2"
	];
}
