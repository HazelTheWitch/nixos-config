{ moduleWithSystem, ... }:

{
  flake.modules.nixos.greetd = moduleWithSystem (
    perSystem @ { pkgs, ... }:
    {
      services.greetd = {
        enable = true;
        settings = {
          default_session = {
            command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway"
            user = "greeter";
          };
        };
      };
    }
  );
}
