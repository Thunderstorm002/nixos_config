{
  description = "A NixOS configuration for a laptop server";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland?submoudules=1&ref=v0.49.0";
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

    sops-nix.url = "github:Mic92/sops-nix";
    agenix.url = "github:ryantm/agenix";

  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      hyprland,
      hy3,
      sops-nix,
      agenix,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      #pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations.nixos-laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./system/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              users.roshan = import ./home/home.nix; # Simplified import
            };
          }
          sops-nix.nixosModules.sops
          agenix.nixosModules.agenix
        ];
      };

      homeConfigurations."roshan" = home-manager.lib.homeManagerConfiguration {
        inherit system;
        modules = [
          agenix.nixosModules.default
        ];
      };
    };
}
