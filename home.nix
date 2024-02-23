{ config, pkgs, inputs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.username = "getmoussed";
  home.homeDirectory = "/home/getmoussed";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  # gtk.enable = true;
  #  gtk.cursorTheme.package = pkgs.bibata-cursors;
  # gtk.cursorTheme.name = "Bibata-Modern-Ice";

  services = {
    gammastep = {
      enable = true;
      provider = "manual";
      latitude = 48.0;
      longitude = 2.0;
    };
  };


  home.packages = with pkgs; [
    firefox
    wofi
    brightnessctl
    bottom
    discord
    gcc
    unzip
    wget
    gzip
    wl-clipboard
    nixd
  ];


  programs.wezterm = {
    enable = true;
    package = inputs.wezterm.packages.${pkgs.system}.default;
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/nvim".source = ./pkgs/nvim;
    ".config/wayfire.ini".source = ./pkgs/wayfire/wayfire.ini;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.git = {
    enable = true;
    userName = "GET MOUSSED";
    userEmail = "moussa.fof.pro@gmail.com";
  };


  programs.zsh = {
    enable = true;
    shellAliases = {
      n = "nvim";
      zbeubzbeub = "ls -la";
      home-switch = "home-manager switch --flake .";
    };
  };

  programs.starship = {
    enable = true;
    settings = builtins.fromTOML (builtins.readFile ./pkgs/zsh/starship.toml);
  };


  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.home-manager.enable = true;
}
