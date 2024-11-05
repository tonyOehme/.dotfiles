{
  description = "My Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      users = [ "tonyyep" ];
    in
    {
      homeConfigurations = builtins.listToAttrs (builtins.concatMap
        (system:
          let mapper = map
            (user:
              {
                name = "${system}/${user}";
                value = home-manager.lib.homeManagerConfiguration {
                  pkgs = import nixpkgs { inherit system; };
                  modules = [ ./home.nix ];
                };
              })
            users; in mapper)
        systems);
    };
}
