{
  description = "Braniacs' home environment flake!";

  inputs = {
    nvim.url = "path:../nvim-flake";
  };

  outputs = { self, nvim }: {
    homeManagerModules.default = { pkgs, ... }: {
      imports = [
        nvim.homeManagerModules.default
      ];

      # Core user settings
      home.packages = [ pkgs.git ];
      programs.zsh = {
        enable = true;
        # ... zsh config ...
      };
    };
  };
}
