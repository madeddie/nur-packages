{
  buildGoModule,
  fetchFromGitHub,
  installShellFiles,
  lib,
  versionCheckHook,
}:

buildGoModule (finalAttrs: {
  pname = "talhelper";
  version = "3.0.28";

  src = fetchFromGitHub {
    owner = "budimanjojo";
    repo = "talhelper";
    rev = "v${finalAttrs.version}";
    hash = "sha256-ZAzj0KMGtm0817zKur088fAoYDMcnrlDXY+DjP5PIVY=";
  };

  vendorHash = "sha256-5cuOUGoSuuc5Ro1XVQGgW+flp3rqaXNhDewzeErq4k0=";

  rev = "f279046f988829b2a38a03f8fd4fb5cebd460dbb";

  ldflags = [
    "-s"
    "-w"
    "-X github.com/budimanjojo/talhelper/v3/cmd.version=v${finalAttrs.version}"
  ];

  subPackages = [
    "."
    "./cmd"
  ];

  nativeBuildInputs = [ installShellFiles ];

  doInstallCheck = true;
  nativeInstallCheckInputs = [
    versionCheckHook
  ];

  postInstall = ''
    installShellCompletion --cmd talhelper \
      --bash <($out/bin/talhelper completion bash) \
      --fish <($out/bin/talhelper completion fish) \
      --zsh <($out/bin/talhelper completion zsh)
  '';

  meta = with lib; {
    changelog = "https://github.com/budimanjojo/talhelper/releases/tag/v${finalAttrs.version}";
    description = "A tool to help creating Talos kubernetes cluster";
    longDescription = ''
      Talhelper is a helper tool to help creating Talos Linux cluster
      in your GitOps repository.
    '';
    homepage = "https://github.com/budimanjojo/talhelper";
    mainProgram = "talhelper";
    maintainers = with maintainers; [ madeddie ];
    license = licenses.bsd3;
  };
})
