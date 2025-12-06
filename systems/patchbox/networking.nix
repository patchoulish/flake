{
	networking = {
		# The hostname to use.
		hostName = "patchbox";

		# Use DHCP.
		useDHCP = lib.mkDefault true;

		networkmanager = {
			enable = true;
		};
	};
}
