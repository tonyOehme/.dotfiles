{ pkgs, ... }: {
  enable = true;
  package = pkgs.alacritty;
  settings = {
    general.import = [ pkgs.alacritty-theme.dracula ];

    env = {
      TERM = "xterm-256color";
    };

    window = {
      decorations = "Buttonless";
      startup_mode = "Maximized";
      option_as_alt = "Both";
    };

    cursor = { style = "Block"; };

    font =
      let
        jetbrainsMono = style: {
          family = "JetBrainsMono Nerd Font";
          inherit style;
        };
      in
      {
        size = 19;
        normal = jetbrainsMono "Regular";
        bold = jetbrainsMono "Bold";
        italic = jetbrainsMono "Italic";
        bold_italic = jetbrainsMono "Bold Italic";
      };

  };
}




