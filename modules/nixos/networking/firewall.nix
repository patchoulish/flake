{
	networking = {
		firewall = {
			# Ensure the firewall is enabled.
			enable = true;
		};

		nftables = {
			# Use nftables instead of iptables.
			enable = true;
		};
	};
}
