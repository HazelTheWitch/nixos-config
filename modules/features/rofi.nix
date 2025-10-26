{ moduleWithSystem, ... }:

{
  flake.modules.homeManager.rofi = moduleWithSystem (
    perSystem @ { lib, ... }:
    {
      programs.rofi = {
        modes = [
          "drun"
        ];
        theme = let
          inherit (lib.formats.rasi) mkLiteral;
        in {
          entry.placeholder = "";
          "*" = {
            background-color = mkLiteral "transparent";
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
          element-text.text-color = mkLiteral "inherit";
          listview.columns = 2;
        };
      };
    }
  );
}
