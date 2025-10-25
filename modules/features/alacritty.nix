{ ... }:

{
  flake.modules.homeManager.alacritty = {
    programs.alacritty = {
      emable = true;
      settings = {
        env.TERM = "xterm-256color";
        font.size = 12;
      };
    };
  };
}
