{
  lib,
  buildGo125Module,
  fetchFromGitHub,
}:

buildGo125Module (finalAttrs: {
  pname = "aws-console";
  version = "0.5.0";

  src = fetchFromGitHub {
    owner = "joshdk";
    repo = "aws-console";
    rev = "v${finalAttrs.version}";
    hash = "sha256-1bTU0Vj6LULASeEbXr5yY53PWdDFx5LRoWp5hCRmF94=";
  };

  vendorHash = "sha256-P0jKY2kBBV7ZWoPtz+37JgYwRdYan8GkkXadlCTi75k=";

  env.CGO_ENABLED = 0;

  ldflags = [
    "-s"
    "-w"
    "-X github.com/joshdk/aws-console/cmd.version=v${finalAttrs.version}"
  ];

  meta = with lib; {
    changelog = "https://github.com/joshdk/aws-console/releases/tag/v${finalAttrs.version}";
    description = "CLI for generating a temporary login URL for the AWS Console";
    homepage = "https://github.com/joshdk/aws-console";
    mainProgram = "aws-console";
    maintainers = with maintainers; [ madeddie ];
    license = licenses.mit;
  };
})
