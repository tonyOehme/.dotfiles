{ ... }:
{
  enable = true;
  lfs.enable = true;
  userName = "Tony Andy Oehme";
  userEmail = "tony-andy.oehme@tum.de";

  # signing = {
  #   signByDefault = true;
  #   key = null;
  # };

  # delta = {
  #   enable = true;
  #   options = {
  #     decorations = {
  #       commit-decoration-style = "bold yellow box ul";
  #       file-decoration-style = "none";
  #       file-style = "bold yellow ul";
  #     };
  #     features = "decorations";
  #     whitespace-error-style = "22 reverse";
  #   };
  # };

  extraConfig =
    {
      rebase = {
        updateRefs = true;
        autosquash = true;
        autostash = true;
      };

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
        conflictstyle = "zdiff3";
      };

      push = {
        autoSetupRemote = true;
      };

      rerere = { enabled = true; };
      commit = { verbose = true; };
      submodule = { recurse = true; };
      transfer = { fsckObjects = true; };
      fetch = { prune = true; fsckObjects = true; };
      receive = { fsckObjects = true; };
    };
}
