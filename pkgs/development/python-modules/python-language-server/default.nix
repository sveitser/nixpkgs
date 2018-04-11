{ stdenv
, jedi, mccabe, future, futures, rope, tox
, yapf, pycodestyle, pluggy, pyflakes
, json-rpc, pydocstyle
, autopep8, pytest, mock, pytestcov
, fetchFromGitHub
, buildPythonPackage
, pythonOlder
, configparser ? null
}:
buildPythonPackage rec {

  pname = "python-language-server";
  version = "0.17.1";

  src = fetchFromGitHub {
    owner = "palantir";
    repo = pname;
    rev = version;
    sha256 = "1k11b5k9lpl43x5av3xs9s4r8n5g8yilwg1r171bkvblx69z3dsd";
  };

  propagatedBuildInputs = [
    future
    mccabe
    jedi
    json-rpc
    yapf
    pycodestyle
    pydocstyle
    pyflakes
    pluggy
    rope
  ] ++ stdenv.lib.optionals (pythonOlder "3.0") [ configparser futures ];

  checkInputs = [ autopep8 mock pytest pytestcov ];

  checkPhase = ''
    HOME=$(mktemp -d) py.test
  '';

  meta = with stdenv.lib; {
    homepage = http://github.com/palantir/python-language-server;
    description = "Language Server for Python";
    license = licenses.mit;
  };
}
