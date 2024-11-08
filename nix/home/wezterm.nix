{ pkgs, ... }: {
  enable = true;
  enableZshIntegration = true;
  package = pkgs.wezterm;
  extraConfig = ''

    font = wezterm.font("JetBrainsMonoNL Nerd Font Propo", { weight = "Medium", italic = false })
    color_scheme = "OneDark (base16)"
    font_size = 19
    window_padding = {
        left = 0,
        right = 0,
        bottom = 0,
        top = 0,
    }
    enable_tab_bar = false
    window_decorations = "RESIZE"

  '';
}
