{ stdenv
, buildPythonPackage
, fetchPypi
, joblib
, matplotlib
, six
, scikitlearn
, decorator
, audioread
, resampy
, soundfile
, pooch
}:

buildPythonPackage rec {
  pname = "librosa";
  version = "0.8.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0fdqlbz3mrm0zc60zvvbrfbw6lv4q4kwv928qk5sxxmvshp9y2xg";
  };

  propagatedBuildInputs = [ joblib matplotlib six scikitlearn decorator audioread resampy soundfile pooch ];

  # No tests
  # 1. Internet connection is required
  # 2. Got error "module 'librosa' has no attribute 'version'"
  doCheck = false;

  # check that import works, this allows to capture errors like https://github.com/librosa/librosa/issues/1160
  pythonImportsCheck = [ "librosa" ];

  meta = with stdenv.lib; {
    description = "Python module for audio and music processing";
    homepage = "http://librosa.github.io/";
    license = licenses.isc;
    maintainers = with maintainers; [ GuillaumeDesforges ];
  };

}
