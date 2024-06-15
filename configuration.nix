# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ pkgs,  overlays, ... }:

{
  # enable flake 
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.overlays = overlays;

  nixpkgs.config.allowUnfree = true;

 nixpkgs.config.permittedInsecurePackages = [
		"openssl-1.1.1w"
 ];

  networking.firewall.enable = false;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 5;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  programs.adb.enable = true;
  programs.dconf.enable = true;
  programs.thunar.enable = true;
  programs.zsh.enable = true;
  programs.nix-ld = {
    enable = true;
	libraries = with pkgs; [
		libgit2 
		prisma-engines 
		unixODBC
		openssl_1_1
	];
  };

  virtualisation.docker.enable = true;

  services.xserver.enable = true;

  environment.unixODBCDrivers = with pkgs.unixODBCDrivers; [ msodbcsql17 psql ]; 

  environment.systemPackages = with pkgs; [
		libsForQt5.qt5.qtquickcontrols2
		libsForQt5.qt5.qtgraphicaleffects
		unixODBC
		openssl_1_1
  ];

  # services.displayManager.sddm = {
  # enable = true;
  # wayland.enable = true;
  # theme = "${import ./system/sddm/theme.nix { inherit pkgs; } }";
  # };
  services.upower.enable = true;

  time.timeZone = "Europe/Paris";
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

  environment.shells = with pkgs; [ zsh ];

  users = {
    defaultUserShell = pkgs.zsh;
    users = {
      getmoussed = {
        isNormalUser = true;
        description = "getmoussed";
        extraGroups = [ "networkmanager" "wheel" "adbusers" "plugdev" "docker" ];
      };
    };
  };


  imports =
    [
      ./hardware-configuration.nix
      ./system/fonts.nix
      ./system/nvidia.nix
      ./system/wayland/wayland.nix
    ];

  system.stateVersion = "23.11";
}
