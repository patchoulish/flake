{ pkgs, inputs', ... }:
{
	home.packages = with pkgs; [
		# Maple Mono       (ligature unhinted, TTF).
		maple-mono.truetype
		# Maple Mono NF    (ligature unhinted).
		maple-mono.NF-unhinted
		# Maple Mono NF CN (ligature unhinted).
		maple-mono.NF-CN-unhinted
		# San Francisco Pro
		inputs'.apple-fonts.packages.sf-pro
		# San Francisco Mono
		inputs'.apple-fonts.packages.sf-mono
		inputs'.apple-fonts.packages.sf-mono-nerd
		# DejaVu
		dejavu_fonts
		# Noto Color Emoji
		noto-fonts-color-emoji
	];

	fonts.fontconfig.defaultFonts = {
		monospace = [ "Maple Mono" "SFMono Nerd Font" ];
		sansSerif = [ "SFProDisplay" ];
		serif = [ "SFProDisplay" ];
	};
}
