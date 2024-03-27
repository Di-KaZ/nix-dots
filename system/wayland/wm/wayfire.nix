{ pkgs, ... }:
{

  programs.wayfire = {
    enable = true;
    plugins = [
      (pkgs.callPackage ../../../pkgs/wayfire/plugins/pixdecor.nix { })
      # (pkgs.callPackage ../../../pkgs/wayfire/plugins/firedecor.nix { })
    ];
  };

}
