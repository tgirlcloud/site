{
  lib,
  pnpm,
  stdenvNoCC,
  nodejs-slim,
  fetchPnpmDeps,
  pnpmConfigHook,
}:
let
  packageJson = lib.importJSON ./package.json;
in
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "tgirlcloud-site";
  inherit (packageJson) version;

  src = ./.;

  nativeBuildInputs = [
    pnpmConfigHook
    pnpm
    nodejs-slim
  ];

  pnpmDeps = fetchPnpmDeps {
    inherit (finalAttrs) pname version src;
    fetcherVersion = 3;
    hash = "sha256-y2ufu2WJMTFQ9EP8up4kXro/Ckim3UnPHzfmOA4Kf+A=";
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
