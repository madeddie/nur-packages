{
  lib,
  buildPythonApplication,
  fetchFromGitHub,
  setuptools,
  setuptools-scm,
  urwid,
  requests,
  simperium,
}:

buildPythonApplication rec {
  pname = "sncli";
  version = "0.4.4";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "insanum";
    repo = "sncli";
    rev = "${version}";
    hash = "sha256-Ldm8oQdJvZXjD2ZdnkK+HZjMkbDXGkJSkai3iuhNziw=";
  };

  nativeBuildInputs = [
    setuptools-scm
  ];

  propagatedBuildInputs = [
    setuptools
    urwid
    requests
    simperium
  ];

  doCheck = false;

  meta = with lib; {
    description = "Simplenote CLI client";
    homepage = "https://github.com/insanum/sncli";
    license = licenses.mit;
    maintainers = with maintainers; [ madeddie ];
  };
}
