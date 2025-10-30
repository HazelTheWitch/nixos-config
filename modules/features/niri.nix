{ niri, ... }: 

{
  flake.modules.nixosModules.niri = {
    imports = [
      niri.nixosModules.niri
    ];
  };

  flake.modules.homeManager.niri =
    { lib, config, ... }:
    let cfg = config.my.niri; in {
    options = {
      my.niri = {
        outputs = lib.mkOption { };
      };
    };

    config = {
      programs.niri.enable = true;
      programs.niri.settings = {
        input = {
          keyboard = {
            repeat-rate = 50;
            repeat-delay = 300;
          };
        };
        output = cfg.outputs;
        binds = {
          "Mod+Q".action.spawn = [ "alacritty" ];
          "Mod+1".action.focus-workspace = 1;
          "Mod+2".action.focus-workspace = 2;
          "Mod+3".action.focus-workspace = 3;
          "Mod+4".action.focus-workspace = 4;
          "Mod+5".action.focus-workspace = 5;
          "Mod+6".action.focus-workspace = 6;
          "Mod+7".action.focus-workspace = 7;
          "Mod+8".action.focus-workspace = 8;
          "Mod+9".action.focus-workspace = 9;
        };
      };
    };
  };
}
