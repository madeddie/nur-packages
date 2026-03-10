{
  lib,
  buildGoModule,
}:

buildGoModule (finalAttrs: {
  pname = "docker-credential-porter";
  version = "0.68.4";

  src = fetchGit {
    url = "git@github.com:porter-dev/code.git";
    ref = "refs/heads/porter-v${finalAttrs.version}";
    rev = "7f482640bcf5f1a6f539f44b988f079d7346f58d";
    submodules = true;
  };

  vendorHash = "sha256-s4az01KHbTGq1IdrWM9SKQRpF0dsNpGCsjIoC+rGxRs=";

  doCheck = false;
  modRoot = "./legacy-backend";
  proxyVendor = true;
  subPackages = [ "cmd/docker-credential-porter" ];

  env.CGO_ENABLED = 0;
  env.GOWORK = "off";

  patchPhase = ''
    sed -i 's/\/\/.*//g' legacy-backend/cmd/docker-credential-porter/main.go
  '';

  ldflags = [
    "-s"
    "-w"
    "-X main.Version=v${finalAttrs.version}"
  ];

  meta = with lib; {
    changelog = "https://github.com/porter-dev/code/releases/tag/${finalAttrs.version}";
    description = "Docker credential helper for Porter (porter.run) users";
    homepage = "https://github.com/porter-dev/code";
    mainProgram = "docker-credential-porter";
    maintainers = with maintainers; [ madeddie ];
    license = licenses.gpl3;
  };
})
