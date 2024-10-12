{
  description = "Tony ADHD Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
    let
      configuration = { pkgs, config, ... }: {
        # List packages installed in system profile. To search by name, run:
        nixpkgs.config.allowUnfree = true;
        # $ nix-env -qaP | grep wget
        environment.systemPackages =
          [
          ];

        homebrew = {
          enable = true;
          casks = [
            "alfred"
            "firefox"
            "maccy"
            "nikitabobko/tap/aerospace"
            "google-chrome"
            "zen-browser"
            "spotify"
            "visual-studio-code"
            "kitty"
            "wezterm"
            "jetbrains-toolbox"
          ];
          brews = [
            "mas"
            "vim"
            "stow"
            "tree-sitter"
            "vesktop"
            "neovim"
            "fzf"
            "docker"
            "tmux"
            "git"
            "tldr"
            "ripgrep"
            "thefuck"
            "zoxide"
            "yazi"
            "tldr"
            "eza"
          ];
          taps = [ ];
          masApps = { };
          onActivation.cleanup = "zap";
          onActivation.autoUpdate = true;
          onActivation.upgrade = true;
        };
        fonts.packages = [
          (pkgs.nerdfonts.override {
            fonts = [ "JetbrainsMono" ];
          })
        ];

        system.defaults = {
          dock = {
            mineffect = "scale";
            autohide = true;
            autohide-delay = 0.0;
            autohide-time-modifier = 0.0;
            expose-animation-duration = 0.0;
            launchanim = false;
          };

          # universalaccess = {
          #   reduceMotion = true;
          #   reduceTransparency = true;
          #   mouseDriverCursorSize = 4.0;
          # };

          keyboard = { swapLeftCtrlAndFn = true; };

          finder = {
            AppleShowAllExtensions = true;
            AppleShowAllFiles = true;
            FXPreferredViewStyle = "clmv";
            _FXShowPosixPathInTitle = true;
            _FXShowPosixPathInTitle = "SCcf";
            ShowPathbar = true;
            ShowStatusBar = true;
          };

          screensaver = {
            askForPassword = true;
            askForPasswordDelay = 0;
          };

          menuExtraClock = {
            Show24Hour = true;
            showDate = 1;
          };

          NSGlobalDomain = {
            AppleMeasurementUnits = "Centimeters";
            AppleShowAllExtensions = true;
            AppleShowScrollBars = "Always";
            KeyRepeat = 1;
            InitialKeyRepeat = 10;
            AppleInterfaceStyle = "Dark";
            AppleTemperatureUnit = "Celsius";
          };

          ".GlobalPreferences"."com.apple.mouse.scaling" = -1.0;

        };

        # system.activationScripts.applications.text =
        #    let
        #       env = pkgs.buildEnv {
        #          #name = "system-applications";
        # paths = config.environment.systemPackages;
        #  pathsToLink = "/Applications";
        # };
        #in
        #pkgs.lib.mkForce ''
        # Set up applications.
        #   echo "setting up /Applications..." >&2
        #    rm -rf /Applications/Nix\ Apps
        #     mkdir -p /Applications/Nix\ Apps
        #      find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
        #       while read src; do
        #app_name=$(basename "$src")
        # echo "copying $src" >&2
        #  ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
        # done
        #'';

        # Auto upgrade nix package and the daemon service.
        services.nix-daemon.enable = true;
        # nix.package = pkgs.nix;

        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        # Create /etc/zshrc that loads the nix-darwin environment.
        programs.zsh.enable = true; # default shell on catalina
        # programs.fish.enable = true;

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 5;

        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = "x86_64-darwin";
      };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#simple
      darwinConfigurations."intel_mac" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              user = "tony-andy.oehme";
            };
          }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."intel_mac".pkgs;
    };
}
