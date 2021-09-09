{ stdenv
, lib
, makeWrapper
, fetchurl
, makeDesktopItem
, copyDesktopItems
, openjdk16
, writeScript
, bash
, imagemagick
}:

let launcher = writeScript "sparrow" ''
  #! ${bash}/bin/bash

  cd $(dirname $(dirname $0))/lib
  modules=$(ls | xargs | tr " " ":")
  ${openjdk16}/bin/java -p $modules -m com.sparrowwallet.sparrow/com/sparrowwallet/sparrow/MainApp $@
'';
in stdenv.mkDerivation rec {
  pname = "sparrow";
  version = "1.4.3";

  src = fetchurl {
    url = "https://github.com/sparrowwallet/${pname}/releases/download/${version}/${pname}-${version}.tar.gz";
    sha256 = "77818bad5f7183696a4be01db1855971b43379fd049e1e3f76ee5919fcddc655";
  };

  nativeBuildInputs = [ makeWrapper copyDesktopItems imagemagick ];

  desktopItems = [
    (makeDesktopItem {
      name = "Sparrow Bitcoin Wallet";
      exec = pname;
      icon = pname;
      desktopName = "Sparrow Bitcoin Wallet";
      genericName = "Bitcoin Wallet";
      categories = "Network;Finance;";
    })
  ];

  buildPhase = ''
    # Extract Sparrow's JIMAGE and replace the OpenJDK modules.
    mkdir mymodules
    pushd mymodules
    ${openjdk16}/bin/jimage extract ../lib/runtime/lib/modules
    ${openjdk16}/bin/jimage extract ${openjdk16}/lib/openjdk/lib/modules
    popd
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/lib
    cp -r mymodules/* $out/lib/
    install -Dmu+x ${launcher} $out/bin/sparrow

    for n in 16 24 32 48 64 96 128 256; do
      size=$n"x"$n
      convert lib/Sparrow.png -resize $size sparrow.png
      install -Dm644 -t $out/share/icons/hicolor/$size/apps ${pname}.png
    done;

    runHook postInstall
  '';

  meta = with lib; {
    description = "A modern desktop Bitcoin wallet application supporting most hardware wallets and built on common standards such as PSBT, with an emphasis on transparency and usability.";
    homepage = "https://sparrowwallet.com";
    license = licenses.asl20;
    maintainers = with maintainers; [ emmanuelrosa ];
    platforms = [ "x86_64-linux" ];
  };
}
