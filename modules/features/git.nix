{ ... }:

{
  flake.modules.nixos.git = {
    programs.git = {
      enable = true;
      config = {
        init.defaultBranch = "main";
      };
    };
  };
}
