{ stdenv, python3Packages, pew }:
with python3Packages; buildPythonApplication rec {
    pname = "pipenv";
    version = "11.10.0";

    src = fetchPypi {
      inherit pname version;
      sha256 = "0v6w9bm2m5iyp0376s5hz1ghq0hcqdjn0v1yjykwsmvp6kjv5dns";
    };

    LC_ALL = "en_US.UTF-8";

    propagatedBuildInputs = [ pew pip requests flake8 ];

    doCheck = false;

    meta = with stdenv.lib; {
      description = "Python Development Workflow for Humans";
      license = licenses.mit;
      platforms = platforms.all;
      maintainers = with maintainers; [ berdario ];
    };
  }
