{
  lib,
  buildGoModule,
}:

buildGoModule (finalAttrs: {
  pname = "docker-credential-porter";
  version = "0.65.13";

  src = fetchGit {
    url = "git@github.com:porter-dev/code.git";
    ref = "refs/heads/porter-v${finalAttrs.version}";
    rev = "712057614a6dd8d0013d1cd97249b34cfd889b85";
    submodules = true;
  };

  vendorHash = "sha256-ELf1+/1rJT4taiAW4TVnLiiNq8t8NcPLWAb5qrEKvIc=";

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
