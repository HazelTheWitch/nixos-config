{ inputs, withSystem, moduleWithSystem, ... }:

let system = "x86_64-linux"; in {
  flake.modules.nixos.penelope = moduleWithSystem (
      perSystem @ { pkgs, ... }:
      {
        imports = [ ./_hardware-configuration.nix ];

        environment.systemPackages = with pkgs; [
          firefox
        ];

        networking.hostName = "penelope";
        time.timeZone = "America/Los_Angeles";

        system.stateVersion = "25.05";
        nix.settings.experimental-features = [ "flakes" "nix-command" ];

        home-manager.users.aurelia = {
          imports = with inputs.self.modules.homeManager; [
            penelope
            aurelia
          ];
      };

      my = {
        disko.devices = {
          main = "/dev/disk/by-id/nvme-Samsung_SSD_990_EVO_Plus_4TB_S7U8NJ0Y707556N";
        };
        stylix = {
          wallpaper = ./wallpaper.jpg;
          theme = ./theme.yml;
        };
      };
    }
  );

  flake.modules.homeManager.penelope = moduleWithSystem (
    perSystem @ { pkgs }:
    {
      my.sway = {
        modifier = "Mod4";
        terminal = "alacritty";
        menu = "rofi -show drun";
        output = {
          "DP-4" = {
            resolution = "1920x1080@119.879Hz";
            position = "1920,0";
          };
          "DP-5" = {
            resolution = "1920x1080@165.003Hz";
            position = "0,0";
          };
        };
      };
    }
  );

  flake.nixosConfigurations.penelope = inputs.nixpkgs.lib.nixosSystem {
    system = system;
    modules = with inputs.self.modules.nixos; [
      inputs.home-manager.nixosModules.home-manager
      disko
      penelope
      aurelia
      bootloader
      nvidia
      pipewire
      ssh
      stylix
      steam
    ];
  };
}
