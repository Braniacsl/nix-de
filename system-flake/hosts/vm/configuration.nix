({ pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Dublin";

  environment.systemPackages = [
    pkgs.zsh
    pkgs.git
    pkgs.wget
  ];

  users.users.ben= {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
  };

  # environment.etc."nvim/init.lua" = {
  #   text = ''
  #     vim.opt.number = true
  #   '';
  # };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.05";
})
