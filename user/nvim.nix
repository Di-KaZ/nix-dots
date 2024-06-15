{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    ripgrep
    fzf
    wget
    wl-clipboard
	neovide
  ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    extraLuaPackages = ps: [ ps.magick ];
  };

  # TODO: replace with flake once it's available
  home.file.
  ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/perso/neovimed";
}
