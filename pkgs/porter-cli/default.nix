{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule (finalAttrs: {
  pname = "porter-cli";
  version = "0.65.9";

  # src = fetchFromGitHub {
  #   owner = "porter-dev";
  #   repo = "code";
  #   tag = "porter-v${finalAttrs.version}";
  #   hash = lib.fakeHash;
  #   private = true;
  # };

  src = fetchGit {
    url = "git@github.com:porter-dev/code.git";
    ref = "main";
    rev = "74adf85b02dea47beb2c740cea0aaa2bd99f21f3";
    # ref = "refs/tags/porter-v${finalAttrs.version}";
    # rev = "108728e0ee448135f8798ff88ca4381717ea7804";
    # rev = "a0bc65b5d6ba9b987eea84bf3ea31204f2cce98d";
  };

  # sourceRoot = "legacy-backend";
  vendorHash = "${lib.fakeHash}";

  env.CGO_ENABLED = 0;

  # rev = "57399302d867a0c8c0923ce36d81c2fe658a9805";

  ldflags = [
    "-s"
    "-w"
    "-X github.com/porter-dev/code/legacy-backend/cli/cmd/version.Version=v${finalAttrs.version}"
  ];

  # postInstall = ''
  #   mv $out/bin/openhue-cli $out/bin/openhue
  # '';

  meta = with lib; {
    changelog = "https://github.com/porter-dev/code/releases/tag/${finalAttrs.version}";
    description = "CLI to interact with porter.run, a Kubernetes-powered Platform as a Service (PaaS) that runs in your own cloud";
    homepage = "https://github.com/porter-dev/code";
    mainProgram = "porter";
    maintainers = with maintainers; [ madeddie ];
    license = licenses.gpl3;
  };
})
