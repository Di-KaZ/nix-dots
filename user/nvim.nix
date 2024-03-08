{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    neovim
    ripgrep
    fzf
    wget
    wl-clipboard
  ];

  home.file.
  ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/pkgs/nvim";
}
