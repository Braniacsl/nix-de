{
  description = "Braniacs' home-manager hyprland configuration flake!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    hyprland.url = "github:hyprwm/Hyprland";
    hypridle.url = "github:hyprwm/hypridle";
    hyprpaper.url = "github:hyprwm/hyprpaper";
    hyprlock.url = "github:hyprwm/hyprlock";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    homeManagerModules.default = { config, pkgs, ... }: {
      
      nixpkgs.overlays = [
        (final: prev: {
          hyprland = inputs.hyprland.packages.${prev.system}.hyprland;
          hypridle = inputs.hypridle.packages.${prev.system}.hypridle;
          hyprpaper = inputs.hyprpaper.packages.${prev.system}.hyprpaper;
          hyprlock = inputs.hyprlock.packages.${prev.system}.hyprlock;
        })
      ];

      home.packages = [
        pkgs.hyprlock
        pkgs.imagemagick
        pkgs.wallust
	pkgs.hyprcursor
	pkgs.bibata-cursors
      ];

      services.swaync = {
        enable = true;
        style = builtins.readFile ./swaync/style.css;
        settings = builtins.fromJSON (builtins.readFile ./swaync/config.json);
      };

      services.swayosd.enable = true;

      xdg.configFile."wallust/templates/waybar.css".text = ''
        @define-color background {{ background }};
        @define-color foreground {{ foreground }};
        @define-color cursor {{ cursor }};
        @define-color color0 {{ color0 }};
        @define-color color1 {{ color1 }};
        @define-color color2 {{ color2 }};
        @define-color color3 {{ color3 }};
        @define-color color4 {{ color4 }};
        @define-color color5 {{ color5 }};
        @define-color color6 {{ color6 }};
        @define-color color7 {{ color7 }};
        @define-color color8 {{ color8 }};
        @define-color color9 {{ color9 }};
        @define-color color10 {{ color10 }};
        @define-color color11 {{ color11 }};
        @define-color color12 {{ color12 }};
        @define-color color13 {{ color13 }};
        @define-color color14 {{ color14 }};
        @define-color color15 {{ color15 }};
      '';

      xdg.configFile."wallust/wallust.toml".text = ''
        backend = "fastresize"
        color_space = "lch"
        palette = "dark"

        [templates]
        waybar = { template = 'waybar.css', target = '~/.config/wallust/wallust-waybar.css' }
      '';

      wayland.windowManager.hyprland = {
        enable = true;
        package = pkgs.hyprland;
        xwayland.enable = true;
        systemd.enable = true;
        settings = (import ./hyprland.nix) { 
            scriptsPath = ./scripts; 
            backgroundPath = ./hyprpaper/backgrounds/cena-lic-lp-nature-cropped.jpg;
          };
      };

      programs.waybar = {
        enable = true;
        settings.mainBar = (import ./waybar/waybar.nix) { scriptsPath = ./waybar/scripts; };
        
        style = ''
          @import "${config.xdg.configHome}/wallust/wallust-waybar.css";
          ${builtins.readFile ./waybar/style.css}
        '';
      };

      services.hypridle = {
        enable = true;
        package = pkgs.hypridle;
        settings = import ./hypridle.nix;
      };

      services.hyprpaper = {
        enable = true;
        package = pkgs.hyprpaper;
        settings = (import ./hyprpaper/hyprpaper.nix) { backgroundsPath = ./hyprpaper/backgrounds; };
      };

      home.sessionVariables = {
        HYPRCURSOR_THEME = "Bibata-Modern-Ice";
        HYPRCURSOR_SIZE = "24";
      };

      home.pointerCursor = {
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
        size = 24;
        gtk.enable = true;
        x11.enable = true;
      };
    };
  };
}
