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

stdenv.mkDerivation rec {
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
    # Replace the Java runtime with the one from Nixpkgs,
    # but with some files from the sparrow tarball
    mkdir myruntime
    cp -r ${openjdk16}/lib/openjdk/* myruntime/
    chmod u+w myruntime/bin
    chmod u+w myruntime/lib
    rm myruntime/lib/modules
    cp lib/runtime/bin/sparrow myruntime/bin/
    cp lib/runtime/lib/modules myruntime/lib/
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/opt/${pname}/lib/runtime
    cp -a bin $out/opt/${pname}
    cp -a lib/app $out/opt/${pname}/lib
    ln -s $out/opt/${pname}/bin/Sparrow $out/bin/${pname}
    cp -a myruntime/* $out/opt/${pname}/lib/runtime/

    patchelf --interpreter $(echo ${stdenv.glibc.out}/lib/ld-linux*) $out/opt/${pname}/bin/Sparrow

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
