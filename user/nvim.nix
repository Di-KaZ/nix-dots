{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    neovim-nightly
    ripgrep
    fzf
    wget
    wl-clipboard
	neovide
  ];

  # TODO: replace with flake once it's available
  home.file.
  ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/perso/neovimed";
}
