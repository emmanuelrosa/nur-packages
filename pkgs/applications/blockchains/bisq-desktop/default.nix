{ stdenv
, lib
, callPackage
, makeWrapper
, fetchurl
, makeDesktopItem
, copyDesktopItems
, imagemagick
, openjdk11
, dpkg
}:
let
  bisq-launcher = callPackage ./launcher.nix { };
in
stdenv.mkDerivation rec {
  version = "1.6.2";
  pname = "bisq-desktop";
  nativeBuildInputs = [ makeWrapper copyDesktopItems dpkg ];

  src = fetchurl {
    url = "https://github.com/bisq-network/bisq/releases/download/v${version}/Bisq-64bit-${version}.deb";
    sha256 = "1mcisy9in5p4lxak67lfbma2gf4v2cbghggcx538vg1gw982khbi";
  };

  icon = fetchurl {
    url = "https://github.com/bisq-network/bisq/blob/v${version}/desktop/package/linux/icon.png";
    sha256 = "1g32mj2h2wfqcqylrn30a8050bcp0ax7g5p3j67s611vr0h8cjkp";
  };

  desktopItems = [
    (makeDesktopItem {
      name = "Bisq";
      exec = "bisq-desktop";
      icon = "bisq";
      desktopName = "Bisq";
      genericName = "Decentralized bitcoin exchange";
      categories = "Network;Utility;";
    })
  ];

  unpackPhase = ''
    dpkg -x $src .
  '';

  installPhase = ''
    mkdir -p $out/lib $out/bin
    cp opt/Bisq/app/desktop-${version}-all.jar $out/lib

    makeWrapper ${openjdk11}/bin/java $out/bin/bisq-desktop-wrapped \
      --add-flags "-jar $out/lib/desktop-${version}-all.jar bisq.desktop.app.BisqAppMain"

    makeWrapper ${bisq-launcher} $out/bin/bisq-desktop \
      --prefix PATH : $out/bin

    copyDesktopItems

    for n in 16 24 32 48 64 96 128 256; do
      size=$n"x"$n
      ${imagemagick}/bin/convert $icon -resize $size bisq.png
      install -Dm644 -t $out/share/icons/hicolor/$size/apps bisq.png
    done;
  '';

  meta = with lib; {
    description = "A decentralized bitcoin exchange network";
    homepage = "https://bisq.network";
    license = licenses.mit;
    maintainers = with maintainers; [ juaningan emmanuelrosa ];
    platforms = [ "x86_64-linux" ];
  };
}
