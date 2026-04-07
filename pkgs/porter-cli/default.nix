{
  lib,
  buildGoModule,
}:

buildGoModule (finalAttrs: {
  pname = "porter-cli";
  version = "0.68.12";

  src = fetchGit {
    url = "git@github.com:porter-dev/code.git";
    ref = "refs/heads/porter-v${finalAttrs.version}";
    rev = "293912d69c54c840ab9beec8d0f2ca57c0d63d80";
    submodules = true;
  };

  vendorHash = "sha256-2KNdEqzz6ZR3d6cvW1szcdj2XJkWk4rr+1vsQ/gPyis=";

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
