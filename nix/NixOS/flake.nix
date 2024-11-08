{
  description = "Tony ADHD NixOS system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    vscode-remote-workaround.url = "github:K900/vscode-remote-workaround/main";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs@{ self, nixpkgs, home-manager, vscode-workaround }:
    let
      configuration = { pkgs, config, system, user, ... }: {
        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget

        vscode-remote-workaround.enable = true;
        # for some reason this fixes home-manger
        users.users.${user} = {
          name = user;
          home = "/home/${user}";
        };
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
            wget
            vim
            yazi
            neovim
            git
            tmux
            tldr
            thefuck
            fzf
            zsh
            zoxide
            rustup
            eza
            ripgrep
            docker
            stow
            nodejs_20
            spicetify-cli
            # gui
            # kitty
            # vesktop
            # google-chrome
            # alacritty
            # vscode
          ];

        # fonts
        fonts.packages = [
          # nerd fonts
          (pkgs.nerdfonts.override { fonts = [ "Meslo" "JetBrainsMono" ]; })
          # regular ass fonts
        ];

        # Auto upgrade nix package and the daemon service.

        # Necessary for using flakes on this system.

        # Create /etc/zshrc that loads the nix-darwin environment.
        # programs.fish.enable = true;

        # Set Git commit hash for darwin-version.

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        nixpkgs.hostPlatform = system;

      };

      # The platform the configuration will be used on.


      users = [
        "testuser"
        "kia"
        "tonyandyoehme"
        "tonymacaroni"
        "tonyyep"
        "nixos"
      ];
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#simple
      nixosConfigurations = builtins.listToAttrs (builtins.concatMap
        (system:
          let platformConfiguration = map
            (username: {
              name = "${system}/${username}";
              value = nixpkgs.lib.nixosSystem
                {
                  inherit system;

                  modules = [
                    ./wsl.nix

                    configuration
                    { _module.args = { inherit system; user = username; }; }


                    home-manager.nixosModules.home-manager
                    {
                      home-manager.useGlobalPkgs = true;
                      home-manager.useUserPackages = true;
                      home-manager.users =
                        builtins.listToAttrs [
                          {
                            name = username;
                            value = import ../home/home.nix;
                          }
                        ];

                      home-manager.extraSpecialArgs = { inherit username; };
                    }

                  ];
                };

            })
            users; in platformConfiguration)
        systems);

      # Expose the package set, including overlays, for convenience.
    };
}

