{ inputs, pkgs, config, ... }:
{
  programs.wezterm = {
    enable = true;
    package = inputs.wezterm.packages.${pkgs.system}.default;
  };

  home.file.".wezterm.lua".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/pkgs/wezterm/.wezterm.lua";

}
