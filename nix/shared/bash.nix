{ pkgs, config, lib, ... }: {


  enable = true;
  enableCompletion = true;
  shellAliases = import ./aliases.nix;
}
