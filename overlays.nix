{ config, pkgs, ... }:

{
  nixpkgs.overlays = [
    (import ./pkgs/wayfire/overlay.nix { pkgs = pkgs; })
  ];
}
