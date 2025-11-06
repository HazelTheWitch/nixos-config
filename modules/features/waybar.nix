{ moduleWithSystem, ... }:

{
  flake.modules.homeManager.waybar = {
    programs.waybar = {
      enable = true;
      systemd.enable = true;
      settings = [
        {
          position = "top";
          height = 24;
          name = "status";
          modules-left = [
            "user"
            "cava"
            "sway/workspaces"
          ];
          modules-center = [
            "clock"
          ];
          modules-right = [
            "tray"
            "cpu"
            "memory"
            "disk"
            "network"
          ];
          cava = {
            method = "pipewire";
            format-icons = [ "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
            bar_delimiter = 0;
            bars = 12;
          };
          "sway/workspaces".format = "{name}";
          disk.format = "disk {percentage_used}%";
          clock = {
            format = "{:%Y-%m-%d %I:%M %p}";
            tooltip = false;
          };
          memory.format = "memory {}%";
          cpu = {
            format = "cpu {}%";
            tooltip = false;
          };
          network = {
            format = "{bandwithUpBits} up / {bandwithDownBits} down";
            tooltip = false;
          };
          user = {
            format = "{user}";
            open-on-click = false;
          };
        }
      ];
      style = ''
        * {
          font-size: 12pt;
        }

        .module {
          padding: 0 10px;
        }

        #workspaces button {
          padding: 0 0;
        }
      '';
    };
  };
}
