{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    monaspace
    cozette
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];
}
