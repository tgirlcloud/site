{
  description = "NodeJS Project Template";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      forAllSystems =
        function:
        nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed (
          system: function nixpkgs.legacyPackages.${system}
        );
    in
    {
      packages = forAllSystems (pkgs: {
        tgirlcloud-site = pkgs.callPackage ./default.nix { };
        default = self.packages.${pkgs.stdenv.hostPlatform.system}.tgirlcloud-site;
      });

      devShells = forAllSystems (pkgs: {
        default = pkgs.callPackage ./shell.nix { };
      });

      overlays.default = final: _: { tgirlcloud-site = final.callPackage ./default.nix { }; };
    };
}
