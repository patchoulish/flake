{ pkgs, inputs', ... }:
{
  fonts.packages = with pkgs; [
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
}
