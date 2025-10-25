{ ... }:

{
  flake.modules.nixos.zsh = {
    programs.zsh.enable = true;
  };

  flake.modules.homeManager.zsh = { lib, config, ... }: {
    programs.zsh = {
      enable = true;
      initContent = lib.mkOrder 500 ''
        export ZSH_CUSTOM="${config.home.homeDirectory}/.oh-my-zsh/custom"
      '';
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
      };
    };
  };
}
