{ ... }:
{
  enable = true;
  lfs.enable = true;
  userName = "Andy Wand";
  userEmail = "tony-andy.oehme@tum.de";

  # signing = {
  #   signByDefault = true;
  #   key = null;
  # };

  extraConfig =
    {
      pull = {
        rebase = true;
        ff = "only";
      };
      init = {
        defaultBranch = "main";
      };
      diff = {
        algorithm = "histogram";
        renames = true;
        wordRegex = ".";
        submodule = "log";
        mnemonicPrefix = true;
        colorMoved = true;
      };

      color = { ui = "auto"; };

      core = {

        editor = "nvim";
        pager = "cat";
        excludesfile = "~/.gitignore_global";
        whitespace = "trailing-space, space-before-tab";
      };
      status = {

        submoduleSummary = true;
        showUntrackedFiles = "all";
      };
      grep = {

        linenumber = true;
        break = true;
        heading = true;
        extendedRegexp = true;
      };
      merge = {
        conflictstyle = "diff3";
      };
      push = {
        autoSetupRemote = true;
        default = "current";
      };
      rerere = { enabled = true; };
      commit = { verbose = true; };
      submodule = { recurse = true; };
      transfer = { fsckObjects = true; };
      fetch = { fsckObjects = true; };
      receive = { fsckObjects = true; };
    };
}
