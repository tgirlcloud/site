{
  lib,
  pnpm,
  nodejs-slim,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation {
  pname = "tgirlcloud-site";
  version = "0.1.0";

  src = ./.;

  nativeBuildInputs = [
    pnpm
    nodejs-slim
  ];

  meta = {
    description = "The source code tgirl.cloud site";
    homepage = "https://github.com/tgirlcloud/site";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ isabelroses ];
  };
}
