{
  description = "Braniacs' main DE flake!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
   
    nvim-flake.url = "path:../nvim-flake";

    hyprland-config.url = "path:../hyprland-flake";

    home-config = {
      url = "path:../home-flake";
      inputs.nvim-flake.follows = "nvim-flake";
    };
  };

  outputs = { self, nixpkgs, home-manager, hyprland-config, home-config, nvim-flake }: 
    let 
      mkHost = uniqueConfig: nixpkgs.lib.nixosSystem {

        system = "x86_64-linux";
        modules = [
          hyprland-config.nixosModules.default

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ben =
              home-config.homeManagerModules.default;
          }

          uniqueConfig
        ];
      };

    in {
      nixosConfigurations = {
        vm = mkHost ./hosts/vm/configuration.nix;
      };
    };

}
