{
	networking = {
		firewall = {
			# Ensure the firewall is enabled.
			enable = true;
		};

		nftables = {
			# Use nftables instead of iptables.
			enable = true;

			ruleset = ''
				table inet filter {
					# Block all incoming connections except for SSH and "ping".
					chain input {
						type filter hook input priority 0;

						# Accept any traffic on the loopback device.
						iifname lo accept

						# Accept trafic originated from us.
						ct state {established, related} accept

						# ICMP
						# Routers may also want: mld-listener-query, nd-router-solicit
						ip6 nexthdr icmpv6 icmpv6 type { destination-unreachable, packet-too-big, time-exceeded, parameter-problem, nd-router-advert, nd-neighbor-solicit, nd-neighbor-advert } accept
						ip protocol icmp icmp type { destination-unreachable, router-advertisement, time-exceeded, parameter-problem } accept

						# Allow "ping".
						ip6 nexthdr icmpv6 icmpv6 type echo-request accept
						ip protocol icmp icmp type echo-request accept

						# Accept SSH connections.
						tcp dport 22 accept

						# Count and drop any other traffic.
						counter drop
					}

					# Allow all outgoing connections.
					chain output {
						type filter hook output priority 0;
						accept
					}

					chain forward {
						type filter hook forward priority 0;
						accept
					}
				}
			'';
		};
	};
}
