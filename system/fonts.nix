{ pkgs, ... }:
let cartograph-cf = import ./fonts/cartograph-cf/default.nix { inherit pkgs; };
in 
{
  fonts.packages = with pkgs; [
    monaspace
    cozette
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
	cartograph-cf
  ];
}
