{ inputs, pkgs, config, ... }:
{
  home.packages = with pkgs; [
    gvfs
    gjs
    bun
    sass
    brightnessctl
  ];

  imports = [ inputs.ags.homeManagerModules.default ];
  programs.ags = {
    enable = true;
    package = inputs.ags.packages.${pkgs.system}.default;
  };
  home.file.".config/ags".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/pkgs/ags";
}
