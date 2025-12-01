{
  lib,
  buildGoModule,
}:

buildGoModule (finalAttrs: {
  pname = "porter-cli";
  version = "latest";

  src = fetchGit {
    url = "git@github.com:porter-dev/code.git";
    ref = "main";
    rev = "17b4877ceed8c2f008e6ce63bdcac52e30b12c3a";
    submodules = true;
  };

  vendorHash = "sha256-/pZg1FFfg5BO8Tfd0bhAGQGQg/Im3cfdKNNNqP7Qa5k=";

  doCheck = false;
  modRoot = "./legacy-backend";
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
