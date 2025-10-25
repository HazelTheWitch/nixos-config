{ moduleWithSystem, ... }:

{
  flake.modules.homeManager.neovim = moduleWithSystem (
    perSystem @ { pkgs, ... }:
    {
      xdg.configFile.nvim = {
        source = builtins.fetchGit {
          url = "https://github.com/HazelTheWitch/nvim";
          rev = "c7a4a35f3c67f32a40570138f66cca1f7abe73a3";
        };
        recursive = true;
      };

      home.packages = with pkgs; [
        neovim
      ];
    }
  );
}
