{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule (finalAttrs: {
  pname = "k8s-resource-cli";
  version = "0.2.1";

  src = fetchFromGitHub {
    owner = "madeddie";
    repo = "k8s-resource-cli";
    rev = "v${finalAttrs.version}";
    hash = "sha256-kfC1uy26Ke4E0EV1lB9XwVkFVq5xPiIQyPAc/BqmEY8=";
  };

  vendorHash = "sha256-gsu57LG318sJEfBcKMkj+XfQihVQmc+1xe0dWDFfBZM=";

  env.CGO_ENABLED = 0;

  ldflags = [
    "-s"
    "-w"
    "-X main.version=v${finalAttrs.version}"
  ];

  meta = with lib; {
    changelog = "https://github.com/madeddie/k8s-resource-cli/releases/tag/v${finalAttrs.version}";
    description = "A vibe-coded CLI tool to calculate k8s pod requests and usage";
    homepage = "https://github.com/madeddie/k8s-resource-cli";
    maintainers = with maintainers; [ madeddie ];
    license = licenses.gpl3;
  };
})
