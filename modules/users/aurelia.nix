{ inputs, moduleWithSystem, ... }:

let
  username = "aurelia";
in{
  flake.modules.nixos.${username} = moduleWithSystem (
    perSystem @ { pkgs, config, ... }:
    {
      imports = with inputs.self.modules.nixos; [
        git
        zsh
      ];

      users.users.${username} = {
        isNormalUser = true;
        shell = pkgs.zsh;
        extraGroups = [ "wheel" ];
      };
    }
  );

  flake.modules.homeManager.${username} = {
    imports = with inputs.self.modules.homeManager; [
      zsh
      sway
      alacritty
      neovim
      rofi
    ];

    home.username = username;

    # Git Configuration
    programs.git = {
      enable = true;
      userName = "Hazel Rella";
      UserEmail = "hazelrella11@gmail.com";
    };

    # Guuji Custom Theme
    programs.zsh.oh-my-zsh.theme = "guuji";
    home.file.guuji = {
      text = ''
        # guuji.zsh-theme

        PROMPT='$FG[211]┌[ $reset_color%B$FG[white]%n$reset_color$FG[211]@$reset_color%B$FG[white]%M$reset_color$FG[211] ]-< $reset_color$FG[white]%~$reset_color$FG[211] >$(git_prompt_info)
        └> % %{$reset_color%}'

        ZSH_THEME_GIT_PROMPT_PREFIX="-( $reset_color$FG[246]git://$reset_color%B$FG[white]"
        ZSH_THEME_GIT_PROMPT_SUFFIX=" $reset_color$FG[211])"
        ZSH_THEME_GIT_PROMPT_DIRTY=" $FG[211]x$reset_color"
      '';
      target = ".oh-my-zsh/custom/themes/guuji.zsh-theme";
    };

    home.stateVersion = "25.05";
  };
}
