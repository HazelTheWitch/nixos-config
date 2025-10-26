{ ... }:

{
  flake.modules.homeManager.rofi = 
  { config, ... }:
  {
    programs.rofi = {
      enable = true;

      modes = [
        "drun"
      ];

      theme = let
        inherit (config.lib.formats.rasi) mkLiteral;
      in {
        entry.placeholder = "";
        "*" = {
          margin = 2;
          padding = 2;
          spacing = 2;
        };
        window = {
          width = mkLiteral "40%";
          padding = 12;
        };
        inputbar.spacing = 5;
        mainbox.spacing = 5;
        listview.spacing = 2;
        listview.columns = 2;
      };
    };
  };
}
