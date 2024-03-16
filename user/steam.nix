{ pkgs, ... }:
{
  programs.zsh.initExtra = ''export XDG_DATA_HOME="$HOME/.local/share"'';
  home.packages = with pkgs; [
    steam
  ];
}
