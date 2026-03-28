{
  description = "NixOS btw";
  inputs = {
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
    nur.url = "github:nix-community/NUR";
    niri.url = "github:sodiboo/niri-flake";
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-unstable
    , home-manager
    , nixvim
    , nur
    , niri
    , ...
    }@inputs:
    let
      system = "x86_64-linux";
      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ nur.overlays.default ];
      };
    in
    {
      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit unstable inputs; };
        modules = [
          ./configuration.nix
          niri.nixosModules.niri
          {
            nixpkgs.overlays = [ nur.overlays.default ];
          }
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.mreblan = import ./home.nix;
              backupFileExtension = "bak";
              extraSpecialArgs = { inherit unstable inputs; };
              sharedModules = [ ];
            };
          }
          { _module.args = { unstable = unstable; }; }
        ];
      };
      homeConfigurations."mreblan" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit unstable inputs; };
        modules = [
          ./home.nix
        ];
      };
    };
}
