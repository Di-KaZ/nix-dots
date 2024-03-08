{ pkgs, config, ... }:
{
  home.file.
  ".config/wayfire.ini".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/pkgs/wayfire/wayfire.ini";
}
