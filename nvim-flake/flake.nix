{
  description = "Braniacs' home-manager modular neovim flake!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: {
    homeManagerModules.default = { pkgs, ... }: {
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };

      programs.neovim = {
        enable = true;
        defaultEditor = true;

        plugins = with pkgs.vimPlugins; [
          plenary-nvim
          nvim-web-devicons
          mini-icons
          nvim-treesitter

          lualine-nvim
          bufferline-nvim
          catppuccin-nvim

          gitsigns-nvim
          which-key-nvim
          flash-nvim
          telescope-nvim
          (telescope-fzf-native-nvim.overrideAttrs (oldAttrs: {
            nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [ pkgs.cmake ];
          }))

          nui-nvim
          neo-tree-nvim
          oil-nvim
          nvim-notify
          noice-nvim
          alpha-nvim
          trouble-nvim
          todo-comments-nvim
          mini-pairs
          nvim-ts-context-commentstring
          persistence-nvim
        ];
      };

      xdg.configFile."nvim/init.lua".source = ./init.lua;

      xdg.configFile."nvim/lua" = {
        source = ./lua;
        recursive = true;
      };
    };
  };
}

