{
  description = "Braniacs' home environment flake!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nvim-flake.url = "path:../nvim-flake";
    hyprland-flake.url = "path: ../hyprland-flake";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };

  outputs = { self, nixpkgs, nvim-flake, hyprland-flake, spicetify-nix }@inputs: {
    homeManagerModules.default = { pkgs, ... }: {
      imports = [
        inputs.nvim-flake.homeManagerModules.default
        inputs.hyprland-flake.homeManagerModules.default
        inputs.spicetify-nix.homeManagerModules.default
      ];

      home.stateVersion = "25.05";

      programs.firefox.enable = true;

      home.packages = [
        pkgs.git
        pkgs.kitty
        pkgs.ghostty
        pkgs.nerd-fonts.monaspace
        pkgs.fastfetch
        pkgs.pnpm
        pkgs.jdk17
        pkgs.sudo-rs
        pkgs.ripgrep
        pkgs.grim
        pkgs.slurp
        pkgs.pavucontrol
        pkgs.playerctl
        pkgs.fd
        pkgs.stremio
      ];

      programs.spicetify = {
        enable = true;
        theme = inputs.spicetify-nix.legacyPackages.${pkgs.system}.themes.text;
      };

      home.file.".p10k.zsh" = {
        source = ./dotfiles/.p10k.zsh;
      };

      home.file.".ssh" = {
        source = ./dotfiles/.ssh;
        recursive = true;
      };

      programs.zsh = {
        enable = true;
        initContent = ''
          source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
          ${builtins.readFile ./dotfiles/.zshrc}
        '';
        profileExtra = ''
          if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
            exec Hyprland
          fi
        '';
        oh-my-zsh = {
          enable = true;
          plugins = [
            "git"
            "branch"
            "colored-man-pages"
            "colorize"
            "command-not-found"
            "docker"
            "docker-compose"
            "rust"
            "ssh"
            "systemd"
            "themes"
          ];
        };
      };
      
      fonts.fontconfig.enable = true;

      programs.ghostty = {
        enable = true; 
        enableZshIntegration  = true;
        settings = {
          font-family = "MonaspiceKr Nerd Font";
          font-size = 14;
          font-feature = [
            "calt"
            "ss01"
            "ss02"
            "ss03"
            "ss04"
            "ss05"
            "ss06"
            "ss07" 
            "ss08"
            "ss09"
          ];
        };
      };

      home.sessionVariables = {
        EDITOR = "nvim";
        JAVA_HOME = "${pkgs.jdk17}";
        WIFI_DEVICE = "wlan0";
        NIX_CONFIG_TYPE="server";
      };
    };
  };
}
