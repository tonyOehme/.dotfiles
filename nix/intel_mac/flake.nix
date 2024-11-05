{
  description = "Tony ADHD Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-homebrew, nix-darwin, nixpkgs }:
    let
      mac = { pkgs, config, ... }: {
        homebrew = {
          enable = true;
          casks = [
            "firefox"
            "jetbrains-toolbox"
            "google-chrome"
            "docker"
            "protonvpn"
            "microsoft-office"
            "microsoft-teams"
            "alfred"
            "shottr"
            "zen-browser"
            "wezterm"
            "iina"
            "keka"
            "spotify"
            "maccy"
            "nikitabobko/tap/aerospace"
          ];
          brews = [
            "mas"
            "pnpm"
          ];
          taps = [ ];
          masApps = { };
          onActivation.cleanup = "zap";
          onActivation.autoUpdate = true;
          onActivation.upgrade = true;
        };

        system.defaults = {
          dock = {
            mineffect = "scale";
            enable-spring-load-actions-on-all-items = true;
            persistent-apps = [
              "/Applications/WezTerm.app"
              "/Applications/Google\ Chrome.app"
              "/Applications/Spotify.app"
              "/Applications/Microsoft\ Teams.app"
            ];
            orientation = "bottom";
            autohide = true;
            tilesize = 128;
            autohide-delay = 0.0;
            autohide-time-modifier = 0.0;
            dashboard-in-overlay = true;
            mouse-over-hilite-stack = true;
            expose-animation-duration = 0.0;
            launchanim = false;
            expose-group-by-app = false;
            show-process-indicators = true;
            show-recents = false;
            minimize-to-application = true;
            mru-spaces = false;
          };

          universalaccess = {
            reduceMotion = true;
            reduceTransparency = true;
            mouseDriverCursorSize = 4.0;
          };

          finder = {
            AppleShowAllExtensions = true;
            AppleShowAllFiles = true;
            _FXSortFoldersFirst = true;
            QuitMenuItem = true;
            FXPreferredViewStyle = "clmv";
            _FXShowPosixPathInTitle = true;
            FXEnableExtensionChangeWarning = true;
            ShowPathbar = true;
            ShowStatusBar = true;
          };

          screensaver = {
            askForPassword = true;
            askForPasswordDelay = 0;
          };

          menuExtraClock = {
            Show24Hour = true;
            ShowDate = 1;
          };

          NSGlobalDomain = {
            AppleInterfaceStyle = "Dark";
            ApplePressAndHoldEnabled = false;
            AppleMetricUnits = 1;
            AppleTemperatureUnit = "Celsius";
            AppleFontSmoothing = 1;
            AppleShowScrollBars = "Always";
            AppleMeasurementUnits = "Centimeters";
            AppleShowAllExtensions = true;
            NSAutomaticSpellingCorrectionEnabled = false;
            NSAutomaticQuoteSubstitutionEnabled = false;
            NSAutomaticPeriodSubstitutionEnabled = false;
            NSAutomaticDashSubstitutionEnabled = false;
            NSAutomaticCapitalizationEnabled = false;
            NSTableViewDefaultSizeMode = 2;
            NSUseAnimatedFocusRing = false;
            NSNavPanelExpandedStateForSaveMode = true;
            NSNavPanelExpandedStateForSaveMode2 = true;
            NSWindowShouldDragOnGesture = true;
            NSAutomaticInlinePredictionEnabled = false;
            PMPrintingExpandedStateForPrint = true;
            PMPrintingExpandedStateForPrint2 = true;
            "com.apple.springing.enabled" = true;
            "com.apple.springing.delay" = 0.0;
            NSAutomaticWindowAnimationsEnabled = false;
            KeyRepeat = 1;
            InitialKeyRepeat = 10;
          };

          ".GlobalPreferences"."com.apple.mouse.scaling" = -1.0;
          CustomSystemPreferences = { com.apple.menuextra.battery.ShowPercent = true; };

        };
        # copy applications from nix folder to macos /Applications
        system.activationScripts.applications.text =
          let
            env = pkgs.buildEnv {
              name = "system-applications";
              paths = config.environment.systemPackages;
              pathsToLink = "/Applications";
            };
          in
          pkgs.lib.mkForce ''
            # Set up applications.
            echo "setting up /Applications..." >&2
            rm -rf /Applications/Nix\ Apps
            mkdir -p /Applications/Nix\ Apps
            find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
            while read src; do
              app_name=$(basename "$src")
              echo "copying $src" >&2
              ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
            done
          '';

        system.keyboard = {
          enableKeyMapping = true;
          swapLeftCtrlAndFn = true;
        };


      };
      configuration = { pkgs, config, system, ... }: {
        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        nixpkgs.config.allowUnfree = true;
        environment.shellAliases = {
          ls = "eza --icons=always";
          n = "nvim .";
          c = "code .";
          a = "tmux attach";
          y = "yazi";
          gap = "git commit -am \"automated push\"; git push' alias b = \"bat\"";
          gwtp = "git pull origin $(git rev-parse --abbrev-ref HEAD)";

        };
        environment.variables = {
          VISUAL = "nvim";
          EDITOR = "nvim";
          GIT_EDITOR = "nvim";
          NVM_DIR = "$HOME/.nvm";
        };
        environment.systemPackages = with pkgs;
          [
            vim
            yazi
            mkalias
            neovim
            git
            tmux
            tldr
            thefuck
            fzf
            zsh
            zoxide
            vesktop
            rustup
            eza
            ripgrep
            alacritty
            docker
            kitty
            vscode
            stow
            nodejs_20
          ];

        # fonts
        fonts.packages = [
          (pkgs.nerdfonts.override { fonts = [ "Meslo" "JetBrainsMono" ]; })
        ];

        # Auto upgrade nix package and the daemon service.
        services.nix-daemon.enable = true;
        nix.package = pkgs.nix;

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
        nixpkgs.hostPlatform = system;

      };

      # The platform the configuration will be used on.


      user = "tony-andy.oehme";
      users = [ "tony-andy.oehme" ];
      platforms = [
        {
          name = "x86_64-darwin";
          nix-homebrew = {
            # Install Homebrew under the default prefix
            enable = true;
            inherit user;
          };
        }
        {
          name = "aarch64-darwin";
          nix-homebrew = {
            # Install Homebrew under the default prefix
            enable = true;
            enableRoseta = true;
            inherit user;
          };
        }
      ];
      combinations = map
        (platform:
          let platform = platform; in
          map
            (
              user: {
                name = platform.name + "+" + user;

                nix-homebrew =
                  if platform.name == "aarch64-darwin"
                  then { enableRoseta = true; inherit user; enable = true; }
                  else { inherit user; enable = true; };
              }
            )
            users)
        platforms;
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#simple
      darwinConfigurations = builtins.listToAttrs (map
        (platform: {
          name = platform.name;
          value = nix-darwin.lib.darwinSystem
            {
              modules = [
                mac
                configuration
                { _module.args = { system = platform.name; }; }
                nix-homebrew.darwinModules.nix-homebrew
                { nix-homebrew = platform.nix-homebrew; }
              ];
            };

        })
        platforms);

      # Expose the package set, including overlays, for convenience.
      darwinPackages = map (platform: self.darwinConfigurations.platform.name.pkgs) platforms;
    };
}
