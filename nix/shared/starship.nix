{ config, pkgs, lib, ... }: {
  enable = true;
  enableBashIntegration = true;
  enableFishIntegration = true;
  enableNushellIntegration = true;
  enableTransience = true;
  settings = builtins.fromTOML (builtins.readFile ../../.config/starship.toml);
}

