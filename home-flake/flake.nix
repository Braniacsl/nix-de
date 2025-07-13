{
  description = "Braniacs' home environment flake!";

  inputs = {
    nvim-flake.url = "path:../nvim-flake";
  };

  outputs = { self, nvim-flake }: {
    homeManagerModules.default = { pkgs, ... }: {
      imports = [
        nvim-flake.homeManagerModules.default
      ];

      home.stateVersion = "25.05";

      # Core user settings
      home.packages = [ pkgs.git ];
    };
  };
}
