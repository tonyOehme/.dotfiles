{
  description = "Tony ADHD Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    homebrew-core = { url = "github:homebrew/homebrew-core"; flake = false; };
    homebrew-cask = { url = "github:homebrew/homebrew-cask"; flake = false; };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-homebrew, homebrew-core, homebrew-cask, nix-darwin, nixpkgs, home-manager }:
    let
      mac_setup = { pkgs, config, ... }: {
        homebrew = {
          enable = true;
          casks = [
            #nix repo version does not work
            "jetbrains-toolbox"
            "firefox"
            #needs to be here because of spicetify
            "spotify"
            #maconly apps
            "docker"
            "protonvpn"
            "microsoft-office"
            "ghostty"
            "alfred"
            "betterdisplay"
            "shottr"
            "zen-browser"
            "visual-studio-code"
            "maccy"
            "google-chrome"
          ];
          brews = [
            "mas"
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
              "/Applications/Ghostty.app"
              "/Applications/Google\ Chrome.app"
              "/Applications/Visual\ Studio\ Code.app"
              "${pkgs.vesktop}/Applications/Vesktop.app"
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


          finder = {
            AppleShowAllExtensions = true;
            FXDefaultSearchScope = "SCcf";
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
            AppleScrollerPagingBehavior = true;
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
          CustomSystemPreferences = { };

        };
        security.pam.services.sudo_local.touchIdAuth = true;


        system.activationScripts.applications.text =
          let
            env = pkgs.buildEnv {
              name = "system-applications";
              paths = config.environment.systemPackages;
              pathsToLink = "/Applications";
            };
          in
          pkgs.lib.mkForce ''
            # show battery percentage in menu bar
            echo "show battery percentage"
            defaults write ~/Library/Preferences/ByHost/com.apple.controlcenter.plist BatteryShowPercentage -bool true

            # Set up applications.
            echo "setting up /Applications..." >&2
            rm -rf /Applications/Nix\ Apps
            mkdir -p /Applications/Nix\ Apps
            find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
            while read -r src; do
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
      configuration = { pkgs, config, system, user, ... }: {
        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        nixpkgs.config.allowUnfree = true;
        # for some reason this fixes home-manger
        users.users.${user} = {
          name = user;
          home = "/Users/${user}";
        };
        environment.shellAliases = import ../shared/aliases.nix;
        environment.variables = import ../shared/variables.nix;
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
            zoxide
            rustup
            eza
            ripgrep
            docker
            ruby
            stow
            nushell
            starship
            nodejs_20
            spicetify-cli
            #gui
            vesktop
            keka
            aerospace
            iina
          ];

        # fonts
        fonts.packages = [
          # nerd fonts
          # regular ass fonts
        ];

        # Auto upgrade nix package and the daemon service.
        nix.package = pkgs.nix;
        nix.enable = true;

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


      users = import ../shared/users.nix;
      systems = [
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      # this seems unnecessary now
      # outputs = builtins.concatMap
      #   (system:
      #     let mapper = map (user: "${system}/${user}") users; in mapper)
      #   systems;

    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#simple
      darwinConfigurations = builtins.listToAttrs (builtins.concatMap
        (system:
          let platformConfiguration = map
            (user: {
              name = "${system}/${user}";
              value = nix-darwin.lib.darwinSystem
                {
                  modules = [
                    mac_setup

                    configuration
                    { _module.args = { inherit system user; }; }

                    nix-homebrew.darwinModules.nix-homebrew
                    {
                      nix-homebrew =
                        if system == "aarch64-darwin"
                        then {
                          inherit user; enable = true;
                          enableRosetta = true;
                          taps = {
                            "homebrew/homebrew-core" = homebrew-core;
                            "homebrew/homebrew-cask" = homebrew-cask;
                          };
                          mutableTaps = false;
                        }
                        else { inherit user; enable = true; };
                    }

                    home-manager.darwinModules.home-manager
                    {
                      home-manager.useGlobalPkgs = true;
                      home-manager.useUserPackages = true;
                      home-manager.users =
                        builtins.listToAttrs [
                          {
                            name = user;
                            value = import ./home.nix;
                          }
                        ];

                      home-manager.extraSpecialArgs = { inherit user; };
                    }

                  ];
                };

            })
            users; in platformConfiguration)
        systems);

      # Expose the package set, including overlays, for convenience.
      darwinPackages = builtins.concatLists
        (system:
          let mapper = map
            (user:
              self.darwinConfigurations."${system}/${user}".pkgs)
            users; in mapper)
        systems;
    };
}

