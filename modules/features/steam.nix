{ moduleWithSystem, ... }:

{
  flake.modules.nixos.steam = moduleWithSystem (
    perSystem @ { pkgs, ... }:
    {
      programs.steam = {
        enable = true;
        localNetworkGameTransfers.openFirewall = true;
      };

      environment.systemPackages = with pkgs; [
        protonup
      ];

      environment.sessionVariables = {
        STEAM_EXTRA_COMPAT_TOOLS_PATH = "\${HOME}/.steam/root/compatibilitytools.d";
      };
    }
  );
}
