{ inputs, pkgs, config, ... }:
{
  programs.zsh = {
    enable = true;
    initExtra = ''
      if command -v nix-your-shell > /dev/null; then
        nix-your-shell zsh | source /dev/stdin
      fi
    '';
    shellAliases = {
      n = "LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH nvim";      
      home-switch = "home-manager switch --flake ${config.home.homeDirectory}/\.dotfiles/.";
      ls = "eza --icons";
    };
  };

  programs.starship = {
    enable = true;
    settings = builtins.fromTOML (builtins.readFile ../pkgs/zsh/starship.toml);
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.atuin = {
    enable = true;
    package = inputs.atuin.packages.${pkgs.system}.default;
    enableZshIntegration = true;
  };
}
