{ inputs, moduleWithSystem, ... }:

{
  flake.modules.nixos.stylix = moduleWithSystem (
    perSystem @ { pkgs, ... }:
    { lib, config, ... }:
    let cfg = config.my.stylix; in {
      imports = [ inputs.stylix.nixosModules.stylix ];

      options = {
        my.stylix = {
          wallpaper = lib.mkOption { type = lib.types.path; };
          theme = lib.mkOption { type = lib.types.path; };
        };
      };

      config = {
        stylix = {
          enable = true;
          image = cfg.wallpaper;
          base16Scheme = cfg.theme;
          fonts = {
            monospace = {
              package = pkgs.nerd-fonts.terminess-ttf;
              name = "Terminess Nerd Font";
            };
          };
        };
      };
    }
  );
}
