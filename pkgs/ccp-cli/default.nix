{
  lib,
  buildGoModule,
}:

buildGoModule (finalAttrs: {
  pname = "ccp-cli";
  version = "latest";

  src = fetchGit {
    url = "git@github.com:porter-dev/code.git";
    ref = "main";
    rev = "17b4877ceed8c2f008e6ce63bdcac52e30b12c3a";
    submodules = true;
  };

  vendorHash = "sha256-fSeJ7oOjRwNZUPCltgX3lCXhMpZrzRM8c6E42lBgFsk=";

  doCheck = false;
  modRoot = "./monolith";
  subPackages = [ "cmd/ccp-cli" ];

  env.CGO_ENABLED = 0;
  env.GOWORK = "off";

  ldflags = [
    "-s"
    "-w"
  ];

  meta = with lib; {
    changelog = "https://github.com/porter-dev/code/releases/tag/${finalAttrs.version}";
    description = "CLI to interact with porter cloud control plane.";
    homepage = "https://github.com/porter-dev/code";
    mainProgram = "ccp-cli";
    maintainers = with maintainers; [ madeddie ];
    license = licenses.gpl3;
  };
})
