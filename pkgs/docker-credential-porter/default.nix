{
  lib,
  buildGoModule,
}:

buildGoModule (finalAttrs: {
  pname = "docker-credential-porter";
  version = "0.65.10";

  src = fetchGit {
    url = "git@github.com:porter-dev/code.git";
    ref = "porter-v0.65.9";
    rev = "7f88e8ff2ded6c8a4276b14fc65e13e5378c3970";
    submodules = true;
  };

  vendorHash = "sha256-iHLPqih1nBybhF0PMVZt/S71d77B1oHm6jcAKssj6wg=";

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
