{ pkgs, ... }: {
  enable = true;
  package = pkgs.alacritty;
  settings = {
    general.import = [ pkgs.alacritty-theme.dracula ];

    env = {
      TERM = "xterm-256color";
    };

    window = {
      padding = {
        x = 0;
        y = 0;
      };
      decorations = "Buttonless";
      opacity = 1;
      option_as_alt = "Both";
      startup_mode = "Maximized";
      decorations_theme_variant = "None";
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




