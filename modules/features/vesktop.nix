{ moduleWithSystem, ... }:

{
  flake.modules.nixos.vesktop = moduleWithSystem (
    perSystem @ { pkgs, ... }:
    {
      xdg.portal = {
        enable = true;
        wlr.enable = true;
      };
    }
  );

  flake.modules.homeManager.vesktop = {
    stylix.targets.vesktop.enable = false;

    programs.vesktop = {
      enable = true;
    };
  };
}
