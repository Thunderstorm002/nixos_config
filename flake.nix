{
  description = "A NixOS configuration for a laptop server";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland?submodules=1&ref=v0.49.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hy3 = {
      url = "github:outfoxxed/hy3?ref=hl0.49.0";
      inputs.hyprland.follows = "hyprland";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kickstart-nixvim.url = "github:JMartJonesy/kickstart.nixvim";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      hyprland,
      hy3,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      batteryWarning = pkgs.callPackage ./modules/system/battery-warning.nix { };
    in
    {
      nixosConfigurations.nixos-laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs batteryWarning; };
        modules = [
          ./system/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs batteryWarning; };
              users.roshan = import ./home/home.nix;
            };
          }
        ];
      };

      packages.${system}.battery-warning = batteryWarning;
    };
}
