{ stdenv
, jedi, mccabe, future, futures, rope, tox
, yapf, pycodestyle, pluggy, pyflakes
, json-rpc, pydocstyle
, autopep8, pytest, mock
, fetchPypi
, buildPythonPackage
, pythonOlder
, configparser ? null
}:
buildPythonPackage rec {

  pname = "python-language-server";
  version = "0.17.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "1hi5npffps5k1gwhgils1bbjhn78i1q4jzhh1v2kqjmc2ac4qmqf";
  };

  postPatch = stdenv.lib.optionalString (!pythonOlder "3.0") ''
    substituteInPlace setup.py --replace "packages=find_packages(exclude=['contrib', 'docs', 'test'])" "packages=find_packages(exclude=['contrib', 'docs'])"
    cat > test/__init__.py <<EOF
# Copyright 2017 Palantir Technologies, Inc.
import pytest
from pyls import IS_WIN

unix_only = pytest.mark.skipif(IS_WIN, reason="Unix only")
windows_only = pytest.mark.skipif(not IS_WIN, reason="Windows only")
EOF
  '';

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

  checkInputs = [ autopep8 mock pytest ];

  checkPhase = ''
    py.test test
  '';

  meta = with stdenv.lib; {
    homepage = http://github.com/palantir/python-language-server;
    description = "Language Server for Python";
    license = licenses.mit;
  };
}

