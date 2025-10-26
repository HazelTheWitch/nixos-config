{ ... }:

{
  flake.modules.homeManager.vesktop = {
    stylix.targets.vesktop.enable = false;

    programs.vesktop = {
      enable = true;
    };
  };
}
