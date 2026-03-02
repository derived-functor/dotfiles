{
  description = "NixOS btw";
  inputs = {
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
    nixpkgs.url = "nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-unstable
    , home-manager
    , zen-browser
    , nixvim
    , ...
    }@inputs:
    let
      system = "x86_64-linux";
      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations.x13 = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit unstable inputs; };
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.mreblan = import ./home.nix;
              backupFileExtension = "bak";
              extraSpecialArgs = { inherit unstable inputs; };
              sharedModules = [ zen-browser.homeModules.twilight-official ];
            };
          }
          { _module.args = { unstable = unstable; }; }
        ];
      };
      homeConfigurations."mreblan" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        extraSpecialArgs = { inherit unstable inputs; };
        modules = [
          ./home.nix
          inputs.zen-browser.homeModules.twilight-official
        ];
      };
    };
}
