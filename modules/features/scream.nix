{ moduleWithSystem, ... }:

{
  flake.modules.nixos.scream = moduleWithSystem (
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [ scream ];

      systemd.user.services.scream = {
        enable = true;
        description = "Scream Audio Server";
        serviceConfig = {
          ExecStart = "${pkgs.scream}/bin/scream -u -p 4011 -i enp11s0 -v";
          Restart = "always";
        };
        wantedBy = [ "default.target" ];
        requires = [ "pipewire-pulse.service" ];
      };
    }
  );
}
