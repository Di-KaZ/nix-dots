{ pkgs, ... }:
let 
cartograph-cf = import ./fonts/cartograph-cf/default.nix { inherit pkgs; };
kirsch = import ./fonts/kirsch/default.nix { inherit pkgs; };
lotion = import ./fonts/lotion/default.nix { inherit pkgs; };
in 
{
  fonts.packages = with pkgs; [
    monaspace
    cozette
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
	cartograph-cf
	kirsch
	victor-mono
	lotion
  ];
}
