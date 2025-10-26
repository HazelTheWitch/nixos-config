{ moduleWithSystem, ... }:

{
  flake.modules.homeManager.sway = moduleWithSystem (
    perSystem @ { pkgs, ... }:
    { lib, config, ... }:
    let cfg = config.my.sway; in {
      options = {
        my.sway = {
          modifier = lib.mkOption { type = lib.types.str; };
          terminal = lib.mkOption { type = lib.types.str; };
          menu = lib.mkOption { type = lib.types.str; };
          output = lib.mkOption { };
        };
      };
      
      config = {
        home.packages = with pkgs; [
          jq
          grim
          slurp
          wl-clipboard
        ];

        xdg.configFile.sway-scripts = {
          source = ./scripts;
          target = "sway/scripts";
          recursive = true;
          executable = true;
        };

        wayland.windowManager.sway = {
          enable = true;
          wrapperFeatures.gtk = true;

          systemd.enable = true;

          config = {
            modifier = cfg.modifier;
            bars = [];
            output = cfg.output;
            window = {
              border = 1;
              titlebar = false;
            };
            input = {
              "*" = {
                repeat_rate = "50";
                repeat_delay = "300";
              };
            };
            startup = [
              { command = "~/.config/sway/scripts/initialize-workspace"; }
            ];
            floating = {
              modifier = cfg.modifier;
              titlebar = false;
              criteria = [
                { app_id = "^firefox$"; title = "^Extension: (Bitwarden Password Manager) - .*"; }
                { class = "XIVLauncher.Core"; }
              ];
            };
            keybindings = {
              "${cfg.modifier}+Shift+r" = "reload";
              "${cfg.modifier}+q" = "exec ${cfg.terminal}";
              "${cfg.modifier}+c" = "kill";
              "${cfg.modifier}+r" = "exec ${cfg.menu}";
              "${cfg.modifier}+Left" = "focus left";
              "${cfg.modifier}+Down" = "focus down";
              "${cfg.modifier}+Up" = "focus up";
              "${cfg.modifier}+Right" = "focus right";
              
              # Workspaces
              "${cfg.modifier}+1" = "exec ~/.config/sway/scripts/focus-workspace 1";
              "${cfg.modifier}+Shift+1" = "exec ~/.config/sway/scripts/move-workspace 1";
              "${cfg.modifier}+2" = "exec ~/.config/sway/scripts/focus-workspace 2";
              "${cfg.modifier}+Shift+2" = "exec ~/.config/sway/scripts/move-workspace 2";
              "${cfg.modifier}+3" = "exec ~/.config/sway/scripts/focus-workspace 3";
              "${cfg.modifier}+Shift+3" = "exec ~/.config/sway/scripts/move-workspace 3";
              "${cfg.modifier}+4" = "exec ~/.config/sway/scripts/focus-workspace 4";
              "${cfg.modifier}+Shift+4" = "exec ~/.config/sway/scripts/move-workspace 4";
              "${cfg.modifier}+5" = "exec ~/.config/sway/scripts/focus-workspace 5";
              "${cfg.modifier}+Shift+5" = "exec ~/.config/sway/scripts/move-workspace 5";
              "${cfg.modifier}+6" = "exec ~/.config/sway/scripts/focus-workspace 6";
              "${cfg.modifier}+Shift+6" = "exec ~/.config/sway/scripts/move-workspace 6";
              "${cfg.modifier}+7" = "exec ~/.config/sway/scripts/focus-workspace 7";
              "${cfg.modifier}+Shift+7" = "exec ~/.config/sway/scripts/move-workspace 7";
              "${cfg.modifier}+8" = "exec ~/.config/sway/scripts/focus-workspace 8";
              "${cfg.modifier}+Shift+8" = "exec ~/.config/sway/scripts/move-workspace 8";
              "${cfg.modifier}+9" = "exec ~/.config/sway/scripts/focus-workspace 9";
              "${cfg.modifier}+Shift+9" = "exec ~/.config/sway/scripts/move-workspace 9";

              "${cfg.modifier}+Shift+Comma" = "move container to output left";
              "${cfg.modifier}+Shift+Period" = "move container to output right";

              # Audio
              "XF86AudioMute" = "exec wpctl set-mute \@DEFAULT_SINK@ toggle";
              "XF86AudioLowerVolume" = "exec wpctl set-volume \@DEFAULT_SINK@ 5%-";
              "XF86AudioRaiseVolume" = "exec wpctl set-volume \@DEFAULT_SINK@ 5%+";
              "XF86AudioMicMute" = "exec wpctl set-mute \@DEFAULT_SOURCE@ toggle";

              # Layout Stuff
              "${cfg.modifier}+b" = "splith";
              "${cfg.modifier}+v" = "splitv";

              "${cfg.modifier}+s" = "layout stacking";
              "${cfg.modifier}+w" = "layout tabbed";
              "${cfg.modifier}+e" = "layout toggle split";

              "${cfg.modifier}+f" = "fullscreen";

              "${cfg.modifier}+Return" = "floating toggle";

              "${cfg.modifier}+a" = "focus parent";

              # Utilities
              "${cfg.modifier}+Print" = "exec grim -g \"$(slurp)\" - | wl-copy";
            };
          };
        };
      };
    }
  );
}
