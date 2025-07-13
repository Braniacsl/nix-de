{
  description = "Braniacs' hyprland configuration flake!";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: {
    nixosModules.default = { config, pkgs, ... }: {
      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
      };
      environment.systemPackages = with pkgs; [
        kitty
        waybar
        wofi
      ];
    };
  };
}
