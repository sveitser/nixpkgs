{ lib
, buildPythonPackage
, fetchFromGitHub
, isPy27
, pytestCheckHook
, fsspec
, future
, pytorch
, pyyaml
, tensorflow-tensorboard
, tqdm
}:

buildPythonPackage rec {
  pname = "pytorch-lightning";
  version = "1.1.1";

  disabled = isPy27;

  src = fetchFromGitHub {
    owner = "PyTorchLightning";
    repo = pname;
    rev = version;
    sha256 = "02cdmpfc3978hvzysylwwx24rv92z9xp61dvqdy3f1pjra54pbrq";
  };

  propagatedBuildInputs = [
    fsspec
    future
    pytorch
    pyyaml
    tensorflow-tensorboard
    tqdm
  ];

  # Can't use tensorflow-tensorboard_2 because pytorch depends on tensorflow-tensorboard_1
  patchPhase = ''
    sed -i 's/tensorboard>=.*/tensorboard/' requirements.txt
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
