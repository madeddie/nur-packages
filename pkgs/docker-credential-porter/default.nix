{
  lib,
  buildGoModule,
}:

buildGoModule (finalAttrs: {
  pname = "docker-credential-porter";
  version = "0.68.11";

  src = fetchGit {
    url = "git@github.com:porter-dev/code.git";
    ref = "refs/heads/porter-v${finalAttrs.version}";
    rev = "68887301ae00a3823fcfebf372dea76f20d355bc";
    submodules = true;
  };

  vendorHash = "sha256-KJ6e1XdnUUz6ewYU/kLB7rynPqtPKIo8OSbYfF5PmW0=";

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
