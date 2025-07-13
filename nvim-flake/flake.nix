{
  description = "Braniacs' standard neovim flake!";

  outputs = { self }: {
    homeManagerModules.default = { pkgs, ... }: {
      programs.neovim = {
        enable = true;
        defaultEditor = true;
        # ... your full user config (plugins, LSP, etc.) goes here
        extraConfig = ''
          " This is the full-featured user configuration
          lua print("Loading full user nvim config!")
        '';
      };
    };
  };
}
