{ lib
, buildPythonPackage
, fetchFromGitHub
, sphinx
, numpydoc
, pytest
, pytest-timeout
, python-lz4
}:


buildPythonPackage rec {
  pname = "joblib";
  version = "0.12.4";

  # get full repository inorder to run tests
  src = fetchFromGitHub {
    owner = "joblib";
    repo = pname;
    rev = version;
    sha256 = "06zszgp7wpa4jr554wkk6kkigp4k9n5ad5h08i6w9qih963rlimb";
  };

  checkInputs = [ sphinx numpydoc pytest pytest-timeout ];
  propagatedBuildInputs = [ python-lz4 ];

  # lz4 compression test breaks when comparing two versions where the first one
  # is prefixed with a "v"
  checkPhase = ''
    py.test joblib -k 'not test_lz4_compression'
  '';

  meta = {
    description = "Lightweight pipelining: using Python functions as pipeline jobs";
    homepage = https://pythonhosted.org/joblib/;
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ costrouc ];
  };
}
