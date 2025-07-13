{
  description = "Braniacs' main DE flake!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    
    hyprland-config.url = "path:../hyprland-flake";
    home-config.url = "path:../home-flake";
  };

  outputs = { self, nixpkgs, home-manager, hyprland-config, home-config }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
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

        ({ config, pkgs, ... }: {
          imports = [ /etc/nixos/hardware-configuration.nix ];
          
          boot.loader.grub.enable = true;
          boot.loader.grub.device = "/dev/vda";
          networking.networkmanager.enable = true;
          time.timeZone = "Europe/Dublin";

          environment.systemPackages = [
            pkgs.neovim
            pkgs.zsh
            pkgs.git
            pkgs.wget
          ];
          
          users.users.ben= {
            isNormalUser = true;
            extraGroups = [ "wheel" ];
            shell = pkgs.zsh;
          };

          environment.etc."nvim/init.lua" = {
            text = ''
              vim.opt.number = true
            '';
          };

          nix.settings.experimental-features = [ "nix-command" "flakes" ];
          system.stateVersion = "25.05";
        })
      ];
    };
  };
}
