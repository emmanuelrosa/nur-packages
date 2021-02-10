{ stdenv, lib, makeWrapper, fetchFromGitHub, gnused, jq, sxiv, libnotify, fd }:

stdenv.mkDerivation rec {
  pname = "rofi-menu";
  version = "0.5.0";

  src = fetchFromGitHub {
    owner = "emmanuelrosa";
    repo = pname;
    rev = version; 
    sha256 = "08bxfg698phwh5b011jxcpjlg3rffnkgmax6vr8z9lj12s8nalp9";
  };

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    install -D rofi-menu-history $out/bin/rofi-menu-history
    install -D rofi-menu-shutdown $out/bin/rofi-menu-shutdown
    install -D rofi-menu-open $out/bin/rofi-menu-open
  '';

  postFixup = ''
    wrapProgram $out/bin/rofi-menu-history --prefix PATH : ${lib.makeBinPath [ gnused jq sxiv ]}
    wrapProgram $out/bin/rofi-menu-open --prefix PATH : ${lib.makeBinPath [ libnotify fd sxiv ]}
  '';

  meta = with lib; {
    description = "Various rofi menus (aka. modi)";
    homepage = "https://github.com/emmanuelrosa/rofi-menu";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = with maintainers; [ emmanuelrosa ];
  };
}
