# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, inputs, lib, stdenv, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;

  # Flake activation
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 5;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  # NVIDIA
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    prime = {
      # sync.enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    };
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Enable Adb
  programs.adb.enable = true;

  virtualisation.docker.enable = true;

  programs.dconf.enable = true;

  # Sound
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };


  xdg.portal = {
    enable = true;
    config.common = {
      default = [ "gtk" ];
    };
    # "org.freedesktop.portal.FileChooser" = [ "thunar" ];
  };



  # Enable login manager
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;

  services.upower.enable = true;

  # Enable wayfire
  programs.wayfire = {
    enable = true;
    plugins = [ (pkgs.callPackage ./pkgs/wayfire/plugins/pixdecor.nix { }) ];
  };

  fonts.packages = with pkgs; [
    monaspace
    cozette
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];


  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  users.users.getmoussed = {
    isNormalUser = true;
    description = "getmoussed";
    extraGroups = [ "networkmanager" "wheel" "adbusers" "plugdev" "docker" ];
    packages = with pkgs; [ ];
  };

  environment.systemPackages = with pkgs; [
    neovim
    git
    appimage-run
  ];

  programs.thunar.enable = true;

  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  system.stateVersion = "23.11";
}
