{ stdenv, buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  name = "doctl-${version}";
  version = "${major}.${minor}.${patch}";
  major = "1";
  minor = "7";
  patch = "2";
  goPackagePath = "github.com/digitalocean/doctl";

  excludedPackages = ''\(doctl-gen-doc\|install-doctl\|release-doctl\)'';
  buildFlagsArray = let t = "${goPackagePath}"; in ''
     -ldflags=
        -X ${t}.Major=${major}
        -X ${t}.Minor=${minor}
        -X ${t}.Patch=${patch}
        -X ${t}.Label=release
   '';

  src = fetchFromGitHub {
    owner = "digitalocean";
    repo = "doctl";
    rev = "v${version}";
    sha256 = "1nkyl5274mbdf4j60f2sj0kvvppcpccf7xws11c9vj9c3zxs7r97";
  };

  meta = {
    description = "A command line tool for DigitalOcean services";
    homepage = https://github.com/digitalocean/doctl;
    license = stdenv.lib.licenses.asl20;
    platforms = stdenv.lib.platforms.all;
    maintainers = [ stdenv.lib.maintainers.siddharthist ];
  };
}
