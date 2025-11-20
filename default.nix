{
  lib,
  pnpm,
  nodejs-slim,
  stdenvNoCC,
}:
let
  packageJson = lib.importJSON ./package.json;
in
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "tgirlcloud-site";
  inherit (packageJson) version;

  src = ./.;

  nativeBuildInputs = [
    pnpm.configHook
    nodejs-slim
  ];

  pnpmDeps = pnpm.fetchDeps {
    inherit (finalAttrs) pname version src;
    fetcherVersion = 2;
    hash = "sha256-mOanv2y4rRG5CGFUxq4LvLWjJ+/CnwIA5rnFZtZ2j2k=";
  };

  buildPhase = ''
    runHook preBuild

    pnpm run build

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -r dist/* $out

    runHook postInstall
  '';

  meta = {
    description = "The source code tgirl.cloud site";
    homepage = "https://github.com/tgirlcloud/site";
    license = lib.licenses.eupl12;
    maintainers = with lib.maintainers; [ isabelroses ];
  };
})
