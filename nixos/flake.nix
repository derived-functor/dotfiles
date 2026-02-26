{
	description = "NixOS btw";
	inputs = {
		nixpkgs.url = "nixpkgs/nixos-25.11";
		nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager/release-25.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ...}:
		let
			system = "x86_64-linux";
			unstable = import nixpkgs-unstable {
			inherit system;
			config.allowUnfree = true;
		};
		in {
			nixosConfigurations.thickpad = nixpkgs.lib.nixosSystem {
				inherit system;
				specialArgs = { inherit unstable; };
				modules = [
					./configuration.nix
						home-manager.nixosModules.home-manager
						{
							home-manager = {
								useGlobalPkgs = true;
								useUserPackages = true;
								users.mreblan = import ./home.nix;
								backupFileExtension = "bak";
								extraSpecialArgs = { inherit unstable; };
							};
						}
						{ _module.args = { unstable = unstable; }; }
				];
		};
	};
}
