{
	networking.firewall = {
		# Disable reverse path filter tests on packets as the required kernel support doesn't exist on Windows (WSL).
		checkReversePath = false;
	};
}
