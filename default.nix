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
    hash = "sha256-zntHo+O8Hck3YjkPwGaHhuYvGIqGEj7JP8YWwUL4TPk=";
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
