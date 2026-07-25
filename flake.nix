{
  description = "dotfiles";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    herdr.url = "github:ogulcancelik/herdr";
  };

  outputs = { self, nixpkgs, home-manager, herdr, ... }: {
    homeConfigurations."molda" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        {
          home.packages = [ herdr.packages.x86_64-linux.default ];
        }
        ./home.nix
      ];
    };
  };
}
