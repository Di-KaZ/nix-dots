{
  description = "GET MOUSSED Nix Config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    android-nixpkgs.url = "github:tadfisher/android-nixpkgs/stable";
    android-nixpkgs.inputs.nixpkgs.follows = "nixpkgs";
    wezterm.url = "github:wez/wezterm?dir=nix";
    ags.url = "github:Aylur/ags/main";
    atuin.url = "github:atuinsh/atuin";
    nix-colors.url = "github:misterio77/nix-colors";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
       url = "github:hyprwm/hyprland-plugins";
       inputs.hyprland.follows = "hyprland";
    };
  };

  outputs = inputs @ { self, nixpkgs, home-manager, android-nixpkgs, atuin, nix-colors, neovim-nightly, hyprland-plugins, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
      overlays = [
        (import ./pkgs/wayfire/overlay.nix { inherit pkgs; })
        inputs.neovim-nightly.overlay
		];
    in
    {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs overlays;
          };
          modules = [
            ./configuration.nix
          ];
        };
      };
      homeConfigurations = {
        "getmoussed" = home-manager.lib.homeManagerConfiguration {
          inherit lib pkgs;
          extraSpecialArgs = { inherit inputs nix-colors overlays; };
          modules = [
            ./home.nix
          ];
        };
      };
    };
}

