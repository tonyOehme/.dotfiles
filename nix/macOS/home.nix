{ config, pkgs, lib, user, ... }:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  build-dependent-pkgs = with pkgs;
    [
      acl
      attr
      bzip2
      curl
      libsodium
      libssh
      libxml2
      openssl
      stdenv.cc.cc
      systemd
      util-linux
      xz
      zlib
      zstd
      glib
      libcxx
    ];

  makePkgConfigPath = x: makeSearchPathOutput "dev" "lib/pkgconfig" x;
  makeIncludePath = x: makeSearchPathOutput "dev" "include" x;

  nvim-depends-library = pkgs.buildEnv {
    name = "nvim-depends-library";
    paths = map lib.getLib build-dependent-pkgs;
    extraPrefix = "/lib/nvim-depends";
    pathsToLink = [ "/lib" ];
    ignoreCollisions = true;
  };
  nvim-depends-include = pkgs.buildEnv {
    name = "nvim-depends-include";
    paths = splitString ":" (makeIncludePath build-dependent-pkgs);
    extraPrefix = "/lib/nvim-depends/include";
    ignoreCollisions = true;
  };
  nvim-depends-pkgconfig = pkgs.buildEnv {
    name = "nvim-depends-pkgconfig";
    paths = splitString ":" (makePkgConfigPath build-dependent-pkgs);
    extraPrefix = "/lib/nvim-depends/pkgconfig";
    ignoreCollisions = true;
  };
  buildEnv = [
    "CPATH=${config.home.profileDirectory}/lib/nvim-depends/include"
    "CPLUS_INCLUDE_PATH=${config.home.profileDirectory}/lib/nvim-depends/include/c++/v1"
    "LD_LIBRARY_PATH=${config.home.profileDirectory}/lib/nvim-depends/lib"
    "LIBRARY_PATH=${config.home.profileDirectory}/lib/nvim-depends/lib"
    "NIX_LD_LIBRARY_PATH=${config.home.profileDirectory}/lib/nvim-depends/lib"
    "PKG_CONFIG_PATH=${config.home.profileDirectory}/lib/nvim-depends/pkgconfig"
  ];
in
{

  home = {
    stateVersion = "24.05";
    homeDirectory = "/Users/${user}";
    username = user;
    packages = with pkgs; [
      patchelf
      nvim-depends-include
      nvim-depends-library
      nvim-depends-pkgconfig
      ripgrep
    ];
  };
  xdg.enable = true;
  xdg.configFile.nvim.source = mkOutOfStoreSymlink "/Users/${user}/personal/.dotfiles/.config/nvim";


  programs = {
    home-manager.enable = true;

    tmux = import ../shared/tmux.nix { inherit pkgs; };
    zsh = import ../shared/zsh.nix { inherit config pkgs lib; };
    zoxide = import ../shared/zoxide.nix { inherit config pkgs; };
    alacritty = import ../shared/alacritty.nix { inherit pkgs; };
    fzf = import ../shared/fzf.nix { inherit pkgs; };
    git = import ../shared/git.nix { inherit pkgs config; };
    wezterm = import ../shared/wezterm.nix { inherit pkgs config; };
  };
}
