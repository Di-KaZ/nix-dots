{ config, pkgs,  overlays, ... }:

{
  # colorScheme = nix-colors.colorSchemes.kanagawa;
  nixpkgs.config.allowUnfree = true;

  home.username = "getmoussed";
  home.homeDirectory = "/home/getmoussed";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  nixpkgs.overlays = overlays;

  services = {
    gammastep = {
      enable = true;
      provider = "manual";
      latitude = 48.0;
      longitude = 2.0;
    };
  };

  home.packages = with pkgs; [
    cargo
    firefox
    wofi
    bottom
    discord
    gcc
    unzip
    gzip
    nixd
    swww
    pfetch
    vscode
    yazi
    nodejs_18
    networkmanagerapplet
    gum
    beekeeper-studio
    eza
    pamixer
    appimage-run
    vlc
    glava
    (import ./dev_envs/dev-env.nix {
      inherit pkgs;
      homeDirectory = config.home.homeDirectory;
    })
  ];


  imports = [
    ./user/env.nix
    ./user/git.nix
    ./user/zsh.nix
    ./user/ags.nix
    ./user/nvim.nix
    ./user/wm/wayfire.nix
    ./user/wezterm.nix
    ./user/steam.nix
  ];


  programs.home-manager.enable = true;
}
