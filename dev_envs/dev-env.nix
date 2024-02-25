{ pkgs, homeDirectory }: pkgs.writeShellApplication {
  name = "dev-env";
  runtimeInputs = with pkgs; [ nix-your-shell zsh ];
  text = ''
    echo "Running dev shell $1"
    nix-your-shell zsh nix develop path:${homeDirectory}/.dotfiles/dev_envs/"$1"/.
  '';
}
