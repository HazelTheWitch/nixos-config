{ inputs, withSystem, moduleWithSystem, ... }:

let system = "x86_64-linux"; in {
  flake.modules.nixos.luna = moduleWithSystem (
      perSystem @ { pkgs, ... }:
      {
        imports = [ ./_hardware-configuration.nix ];

        environment.systemPackages = with pkgs; [
          firefox
        ];

        networking.hostName = "luna";
        time.timeZone = "America/Los_Angeles";

        networking.networkmanager.enable = true;

	hardware.graphics.enable = true;

        system.stateVersion = "25.05";
        nix.settings.experimental-features = [ "flakes" "nix-command" ];

        home-manager.users.aurelia = {
          imports = with inputs.self.modules.homeManager; [
            luna
            aurelia
          ];
      };

      my = {
        disko.devices = {
          main = "/dev/disk/by-id/nvme-WD_BLACK_SN770M_2TB_2530DP400800";
        };
        stylix = {
          wallpaper = ./wallpaper.jpg;
          theme = ./theme.yml;
        };
      };
    }
  );

  flake.modules.homeManager.luna = moduleWithSystem (
    perSystem @ { pkgs }:
    {
      my.sway = {
        modifier = "Mod4";
        terminal = "alacritty";
        menu = "rofi -show drun";
        output = {};
      };
    }
  );

  flake.nixosConfigurations.luna = inputs.nixpkgs.lib.nixosSystem {
    system = system;
    modules = with inputs.self.modules.nixos; [
      inputs.home-manager.nixosModules.home-manager
      disko
      luna
      aurelia
      bootloader
      pipewire
      ssh
      stylix
    ];
  };
}
