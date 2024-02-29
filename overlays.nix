{ config, pkgs, lib, ... }:

{
  nixpkgs.overlays = [
    (import ./pkgs/wayfire/overlay.nix { pkgs = pkgs; })
  ];
}
