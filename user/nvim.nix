{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    neovim-nightly
    ripgrep
    fzf
    wget
    wl-clipboard
    steam-run
  ];

  home.file.
  ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/pkgs/new_nvim";
}
