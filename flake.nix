{
  description = "GET MOUSSED Nix Config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
    android-nixpkgs.url = "github:tadfisher/android-nixpkgs/stable";
    android-nixpkgs.inputs.nixpkgs.follows = "nixpkgs";
    wezterm.url = "github:wez/wezterm?dir=nix";
    ags.url = "github:Aylur/ags/v1.8.0";
    atuin.url = "github:atuinsh/atuin";
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { self, nixpkgs, home-manager, android-nixpkgs, atuin, nix-colors, ... } @inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./overlays.nix
            ./configuration.nix
          ];
        };
      };
      homeConfigurations = {
        "getmoussed" = home-manager.lib.homeManagerConfiguration {
          inherit lib pkgs;
          extraSpecialArgs = { inherit inputs nix-colors; };
          modules = [
            ./home.nix
          ];
        };
      };
    };
}
