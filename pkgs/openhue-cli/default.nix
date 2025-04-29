{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "openhue-cli";
  version = "0.16";

  src = fetchFromGitHub {
    owner = "openhue";
    repo = pname;
    rev = version;
    hash = "sha256-YkY4AMCvv6IlT1xa8kpTaeTBLhAwnJkqeXWrM+LEQck=";
  };

  vendorHash = "sha256-ik7fVUZfJRTVv9ToO/S4QizEY5YWrFmRCWC1COkLLJo=";

  postInstall = ''
    mv $out/bin/openhue-cli $out/bin/openhue
  '';

  meta = with lib; {
    description = "CLI for interacting with Philips Hue smart lighting systems";
    homepage = "https://github.com/openhue/openhue-cli";
    license = licenses.asl20;
    maintainers = with maintainers; [ madeddie ];
    mainProgram = "openhue";
    platforms = platforms.all;
  };
}
