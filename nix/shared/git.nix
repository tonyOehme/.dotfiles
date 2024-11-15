{ pkgs, lib, ... }:
{
  enable = true;
  lfs.enable = true;
  ignores = lib.filter (line: !builtins.isList line) (lib.strings.split "\n" (builtins.readFile ../../.config/git/ignore));

  extraConfig = builtins.fromTOML (builtins.readFile ../../.config/git/conf);
}
