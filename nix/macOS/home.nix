{ user, ... }: {
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
  home.homeDirectory = "/Users/tonymacaroni";
  home.username = "${user}";
}
