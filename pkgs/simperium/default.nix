{
  lib,
  buildPythonPackage,
  fetchPypi,
  requests,
}:

buildPythonPackage rec {
  pname = "Simperium3";
  version = "0.1.5";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-eLgYa+GIaa1f2F6D3VDsK5StT0c9D22fneOYoQEU0Tc=";
  };

  propagatedBuildInputs = [
    requests
  ];

  # No tests in PyPI sdist
  doCheck = false;

  meta = with lib; {
    description = "Python3 fork of library for Simperium (https://github.com/Simperium/simperium-python)";
    homepage = "https://git.sr.ht/~swalladge/python-simperium3";
    license = licenses.mit;
    maintainers = with maintainers; [ madeddie ];
  };
}
