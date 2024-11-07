{ pkgs, ... }: {
  enable = true;
  settings = {
    import = [ pkgs.alacritty-theme.tokyo-night ];
    env = {

      TERM = "xterm-256color";
    };
    window = {

      decorations = "Buttonless";
      startup_mode = "Maximized";
      option_as_alt = "Both";
    };


    shell = {
      program = pkgs.zsh;
    };

  };
}




