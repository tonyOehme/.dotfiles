{
  description = "mac settings only";


  inputs = {
    # Use `github:NixOS/nixpkgs/nixpkgs-25.05-darwin` to use Nixpkgs 25.05.
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    # Use `github:nix-darwin/nix-darwin/nix-darwin-25.05` to use Nixpkgs 25.05.
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
    let
      mac_setup = { pkgs, config, ... }: {

        system.defaults = {
          dock = {
            mineffect = "scale";
            enable-spring-load-actions-on-all-items = true;
            persistent-apps = [
              "/Applications/Ghostty.app"
              "/Applications/Google\ Chrome.app"
              "/Applications/Visual\ Studio\ Code.app"
              "/Applications/Discord.app"
                            "/Applications/System\ Settings.app"
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

        # Auto upgrade nix package and the daemon service.
        nix.package = pkgs.nix;
        nix.enable = true;

        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        system.primaryUser = user;
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

