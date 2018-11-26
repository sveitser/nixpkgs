{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
  name = "iosevka-symbols-20181126";

  src = fetchFromGitHub {
    owner = "sveitser";
    repo = "iosevka-symbols";
    rev = "d930c61377ef39a769ee41843479f1353194c5e4";
    sha256 = "197yx7m73wrmkf4vbqz7l7p1k908mn13kfphakl6scqyq2w6g00i";
  };

  installPhase = ''
    fontdir="$out/share/fonts/truetype"
    mkdir -p "$fontdir"
    cp .fonts/* "$fontdir"
  '';

  meta = with stdenv.lib; {
    description = "Iosevka unicode ligature glyphs in private use area";
    longDescription = ''
      Iosevka uses ligatures, which some editors don’t support.
      This addition adds them as glyphs to the private unicode use area.
      See https://github.com/hlissner/doom-emacs/issues/695.
    '';
    license = licenses.ofl;
    maintainers = [ maintainers.sveitser ];
    homepage = "https://github.com/hlissner/doom-emacs/issues/695";
  };
}
