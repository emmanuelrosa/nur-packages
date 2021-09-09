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

  modulePath=$(dirname $(dirname $0))/lib
  params=(
    --module-path $modulePath
    --add-opens javafx.graphics/com.sun.javafx.css=org.controlsfx.controls
    --add-opens javafx.graphics/javafx.scene=org.controlsfx.controls
    --add-opens javafx.controls/com.sun.javafx.scene.control.behavior=org.controlsfx.controls
    --add-opens javafx.controls/com.sun.javafx.scene.control.inputmap=org.controlsfx.controls
    --add-opens javafx.graphics/com.sun.javafx.scene.traversal=org.controlsfx.controls
    --add-opens javafx.base/com.sun.javafx.event=org.controlsfx.controls
    --add-opens javafx.controls/javafx.scene.control.cell=com.sparrowwallet.sparrow
    --add-opens org.controlsfx.controls/impl.org.controlsfx.skin=com.sparrowwallet.sparrow
    --add-opens org.controlsfx.controls/impl.org.controlsfx.skin=javafx.fxml
    --add-opens javafx.graphics/com.sun.javafx.tk=centerdevice.nsmenufx
    --add-opens javafx.graphics/com.sun.javafx.tk.quantum=centerdevice.nsmenufx
    --add-opens javafx.graphics/com.sun.glass.ui=centerdevice.nsmenufx
    --add-opens javafx.controls/com.sun.javafx.scene.control=centerdevice.nsmenufx
    --add-opens javafx.graphics/com.sun.javafx.menu=centerdevice.nsmenufx
    --add-opens javafx.graphics/com.sun.glass.ui=com.sparrowwallet.sparrow
    --add-opens javafx.graphics/com.sun.javafx.application=com.sparrowwallet.sparrow
    --add-opens java.base/java.net=com.sparrowwallet.sparrow
    --add-opens java.base/java.io=com.google.gson
    --add-reads com.sparrowwallet.merged.module=java.desktop
    --add-reads com.sparrowwallet.merged.module=java.sql
    --add-reads com.sparrowwallet.merged.module=com.sparrowwallet.sparrow
    --add-reads com.sparrowwallet.merged.module=logback.classic
    --add-reads com.sparrowwallet.merged.module=com.fasterxml.jackson.databind
    --add-reads com.sparrowwallet.merged.module=com.fasterxml.jackson.annotation
    --add-reads com.sparrowwallet.merged.module=com.fasterxml.jackson.core
    -m com.sparrowwallet.sparrow
  )

  /nix/store/anwva8fk7zf2ykjkzggjkg38wd7sxx39-openjdk-16+36/bin/java ''${params[@]} $@
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
