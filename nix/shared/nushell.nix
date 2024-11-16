{ pkgs, ... }: {
  enable = true;

  shellAliases = import ./aliases.nix;
  envFile.source = ../../.config/env.nu;
  configFile.source = ../../.config/config.nu;
}
