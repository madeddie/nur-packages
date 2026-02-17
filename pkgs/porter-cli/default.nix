{
  lib,
  buildGoModule,
}:

buildGoModule (finalAttrs: {
  pname = "porter-cli";
  version = "0.67.0";

  src = fetchGit {
    url = "git@github.com:porter-dev/code.git";
    ref = "refs/heads/porter-v${finalAttrs.version}";
    rev = "f43914923787d2670b1bd3c4235b58c162c678bd";
    submodules = true;
  };

  vendorHash = "sha256-m8tQfH4rZTkQeza1woEqm0r3B5S8uoxTCjUIeYCh8cc=";

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
