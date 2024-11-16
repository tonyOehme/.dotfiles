{ pkgs, ... }: {
  enable = true;

  shellAliases = import ./aliases.nix;
  envFile.source = ../../.config/nushell/env.nu;
  configFile.source = ../../.config/nushell/config.nu;
}
