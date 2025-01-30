{
  mkShellNoCC,
  callPackage,

  astro-language-server,
}:
let
  defaultPackage = callPackage ./default.nix { };
in
mkShellNoCC {
  inputsFrom = [ defaultPackage ];

  packages = [
    astro-language-server
  ];
}
