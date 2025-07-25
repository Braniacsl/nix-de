{
  description = "Braniacs' main DE flake!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
   
    nvim-flake.url = "path:../nvim-flake";

    hyprland-flake.url = "path:../hyprland-flake";

    home-flake = {
      url = "path:../home-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nvim-flake.follows = "nvim-flake";
      inputs.hyprland-flake.follows = "hyprland-flake";
    };
  };

  outputs = { self, nixpkgs, home-manager, hyprland-flake, home-flake, nvim-flake }: 
    let 
      mkHost = uniqueConfig: nixpkgs.lib.nixosSystem {

        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ben =
              home-flake.homeManagerModules.default;
          }

          uniqueConfig
        ];
      };

    in {
      nixosConfigurations = {
        vm = mkHost ./hosts/vm/configuration.nix;
        server = mkHost ./hosts/server/configuration.nix;
      };
    };

}
