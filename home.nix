{ config, pkgs, inputs, nix-colors, ... }:

{
  # colorScheme = nix-colors.colorSchemes.kanagawa;
  nixpkgs.config.allowUnfree = true;

  home.username = "getmoussed";
  home.homeDirectory = "/home/getmoussed";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  gtk.enable = true;
  gtk.cursorTheme.package = pkgs.bibata-cursors;
  gtk.cursorTheme.name = "Bibata-Modern-Ice";
  gtk.iconTheme.package = pkgs.papirus-icon-theme;
  gtk.iconTheme.name = "Papirus";


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
    swww
    pfetch
    steam
    vscode
    bun
    gvfs
    gjs
    sassc
    yazi
    nodejs_18
    networkmanagerapplet
    upscayl
    gum
    beekeeper-studio
    neovide
    eza
    (import ./dev_envs/dev-env.nix {
      inherit pkgs;
      homeDirectory = config.home.homeDirectory;
    })
  ];

  programs.atuin = {
    enable = true;
    package = inputs.atuin.packages.${pkgs.system}.default;
    enableZshIntegration = true;
  };

  programs.ags = {
    enable = true;
    package = inputs.ags.packages.${pkgs.system}.default;
  };

  programs.wezterm = {
    enable = true;
    package = inputs.wezterm.packages.${pkgs.system}.default;
  };

  home.file = {
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/pkgs/nvim";
    ".config/ags".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/pkgs/ags";
    ".config/wayfire.ini".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/pkgs/wayfire/wayfire.ini";
  };

  home.sessionVariables = {
    EDITOR = "neovide";
  };

  programs.git = {
    enable = true;
    userName = "GET MOUSSED";
    userEmail = "moussa.fof.pro@gmail.com";
    includes =
      [
        {
          condition = "gitdir:${config.home.homeDirectory}/come_on/";
          contents = {
            user = {
              email = "m.fofana@come-on.co";
              name = "Moussa Fofana";
            };
            core = {
              sshCommand = "ssh -i ${config.home.homeDirectory}/.ssh/come_on";
            };
          };
        }
      ];
  };


  programs.zsh = {
    enable = true;
    initExtra = ''
      if command -v nix-your-shell > /dev/null; then
        nix-your-shell zsh | source /dev/stdin
      fi
    '';

    shellAliases = {
      n = "neovide";
      home-switch = "home-manager switch --flake ${config.home.homeDirectory}/\.dotfiles/.";
      ls = "eza --icons";
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

