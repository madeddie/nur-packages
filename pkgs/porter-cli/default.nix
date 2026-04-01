{
  lib,
  buildGoModule,
}:

buildGoModule (finalAttrs: {
  pname = "porter-cli";
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
  subPackages = [ "cli" ];

  env.CGO_ENABLED = 0;
  env.GOWORK = "off";

  patchPhase = ''
    sed -i 's/\/\/.*//g' legacy-backend/cli/main.go
  '';

  ldflags = [
    "-s"
    "-w"
    "-X github.com/porter-dev/code/legacy-backend/cli/cmd/version.Version=v${finalAttrs.version}"
  ];

  postInstall = ''
    mv $out/bin/cli $out/bin/porter
  '';

  meta = with lib; {
    changelog = "https://github.com/porter-dev/code/releases/tag/${finalAttrs.version}";
    description = "CLI to interact with porter.run, a Kubernetes-powered Platform as a Service (PaaS) that runs in your own cloud";
    homepage = "https://github.com/porter-dev/code";
    mainProgram = "porter";
    maintainers = with maintainers; [ madeddie ];
    license = licenses.gpl3;
  };
})
