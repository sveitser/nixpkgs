{ lib
, buildPythonPackage
, fetchFromGitHub
, isPy27
, pytestCheckHook
, aiohttp
, fsspec
, future
, pytorch
, pyyaml
, tensorflow-tensorboard
, tqdm
}:

buildPythonPackage rec {
  pname = "pytorch-lightning";
  version = "1.2.0";

  disabled = isPy27;

  src = fetchFromGitHub {
    owner = "PyTorchLightning";
    repo = pname;
    rev = version;
    sha256 = "061b9ra6c4p9n4ngqg2ksg9826h5akprkv41bkbypdi1jgywciv5";
  };

  propagatedBuildInputs = [
    aiohttp
    fsspec
    future
    pytorch
    pyyaml
    tensorflow-tensorboard
    tqdm
  ];

  # Can't use tensorflow-tensorboard_2 because pytorch depends on tensorflow-tensorboard_1
  patchPhase = ''
    sed -i 's/tensorboard.*/tensorboard/' requirements.txt
    sed -i 's/PyYAML.*/PyYAML/' requirements.txt
  '';

  checkInputs = [ pytestCheckHook ];

  # Some packages are not in NixPkgs; other tests try to build distributed
  # models, which doesn't work in the sandbox.
  doCheck = false;

  pythonImportsCheck = [ "pytorch_lightning" ];

  meta = with lib; {
    description = "Lightweight PyTorch wrapper for machine learning researchers";
    homepage = "https://pytorch-lightning.readthedocs.io";
    license = licenses.asl20;
    maintainers = with maintainers; [ tbenst ];
  };
}
