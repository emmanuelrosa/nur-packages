# This script is for the Bisq Nix package maintainers.
# This script builds Bisq within a fixed-point derivation,
# which allows Gradle to download dependencies.
# After which, it produces deps.nix, which declares all of the
# dependencies downloaded by Gradle, creating a fixed-point
# derivation for each one. This effectively "pins" the dependencies.
# deps.nix is used by default.nix, which is the Bisq package,
# to provide the (Java) dependencies so that the package can be
# built in a reproducable way.

# USAGE:
# 1. `nix build -f mkdeps.nix`
# If needed, update the `outputHash` at REF1, below. Then repeat step 1.
# 2. `cp ./result deps.nix`
# 3. Build as usual: `nix build bisq-desktop`

with import <nixpkgs> { };
let
  jdk = pkgs.openjdk11.overrideAttrs (oldAttrs: rec {
    buildInputs = pkgs.lib.remove pkgs.gnome2.gnome_vfs oldAttrs.buildInputs;
    NIX_LDFLAGS = builtins.replaceStrings [ "-lgnomevfs-2" ] [ "" ] oldAttrs.NIX_LDFLAGS;
  });
  version = "1.5.9";
  name = "bisq-desktop";

  src = (pkgs.fetchgit rec {
    url = https://github.com/bisq-network/bisq;
    rev = "v${version}";
    sha256 = "0xhmc69gw7d3cdsc84pkpz5ga8v9d9hn7flh07n68c0f9ngz1smp";
    postFetch = ''
      cd $out
      git clone $url
      cd bisq
      git lfs install --force --local
      git lfs pull
      cp -v p2p/src/main/resources/* $out/p2p/src/main/resources/
      cd ..
      rm -rf bisq
    '';
  }).overrideAttrs (oldAttrs: {
    nativeBuildInputs = oldAttrs.nativeBuildInputs or [] ++ [ git-lfs ];
  });

  grpc = callPackage ./grpc-java.nix {};

  gradle = (pkgs.gradleGen.override {
    java = jdk;
  }).gradle_5_6;

  # fake build to pre-download deps into fixed-output derivation
  prebuild = pkgs.stdenv.mkDerivation {
    name = "${name}-prebuild";
    inherit src;
    buildInputs = [ gradle pkgs.perl pkgs.unzip pkgs.zip ];

    patchPhase = ''
      substituteInPlace ./build.gradle \
        --replace 'artifact = "com.google.protobuf:protoc:''${protocVersion}"' "path = '${pkgs.protobuf3_10}/bin/protoc'"
      substituteInPlace ./build.gradle \
        --replace 'artifact = "io.grpc:protoc-gen-grpc-java:''${grpcVersion}"' "path = '${grpc}/bin/protoc-gen-rpc-java'"
    '';

    buildPhase = ''
      export GRADLE_USER_HOME=$(mktemp -d)
      gradle --no-daemon desktop:build --exclude-task desktop:test
    '';

    # perl code mavenizes pathes (com.squareup.okio/okio/1.13.0/a9283170b7305c8d92d25aff02a6ab7e45d06cbe/okio-1.13.0.jar -> com/squareup/okio/okio/1.13.0/okio-1.13.0.jar)
    installPhase = ''
      find $GRADLE_USER_HOME -type f -regex '.*\.\(jar\|pom\)' \
        | perl -pe 's#(.*/([^/]+)/([^/]+)/([^/]+)/[0-9a-f]{30,40}/([^/\s]+))$# ($x = $2) =~ tr|\.|/|; "install -Dm444 $1 \$out/$x/$3/$4/$5" #e' \
        | sh

   '';

    dontStrip = true;

    outputHashAlgo = "sha256";
    outputHashMode = "recursive";

    # REF1
    outputHash = "1f2sziaj32cszvc0vgmi4j6qr3kfw67mc2x0mw6a39alr9xac8ph";
  };

  header = ./bisq-gen-deps-header.nix.txt;
  footer = ./bisq-gen-deps-footer.nix.txt;
  missingDeps = ./bisq-gen-deps-missing.nix.txt;

  gen-deps-script = pkgs.writeScript "${name}-gen-deps-script" ''
    excludes="gradle-witness bitcoinj-2a80db4 btcd-cli4j-core-27b94333 btcd-cli4j-daemon-27b94333 btcd-cli4j-core-27b94333 btcd-cli4j-parent-27b94333 tor.external-32779ac tor.native-32779ac parent-32779ac tor-32779ac tor-binary-macos-a4b868a tor-binary-linux32-a4b868a tor-binary-windows-a4b868a tor-binary-linux64-a4b868a tor-binary-a4b868a tor-binary-geoip-a4b868a jsocks-567e1cd jtorctl-1.5" 
    cat ${header}
    for path in $(find -L ${prebuild} -type f); do
      name=$(basename $path)
      skip=0
  
      for n in $excludes; do
        if [ "$name" == "$n.pom" ]
        then
          skip=1
        elif [ "$name" == "$n.jar" ]
        then
          skip=1
        fi
      done
  
      if [ "$skip" == "1" ] 
      then 
        continue 
      fi
  
      # Override some values which are derived incorrectly,
      # for some unknown reason.
      case "$name" in
        "shadow-5.2.0.pom")
          urlPrefix="https://plugins.gradle.org/m2" 
          sha256="1yc8rwqnwj7j0gagdgyglchbg9jrjg6rcknadns68s6iym68yijl"
          ;;
  
        "shadow-5.2.0.jar")
          urlPrefix="https://plugins.gradle.org/m2" 
          sha256="1j56ddyj71jvaypwhgz25nxh5ffsa58ykwp16pscw6pisrkdlj5p"
          ;;
  
        *)
          urlPrefix="https://repo1.maven.org/maven2" 
          sha256=$(sha256sum -z $path | cut -d " " -f 1)
          ;;
      esac
  
      upstreamPath=$(realpath --relative-to ${prebuild} $path)
      upstreamDir=$(dirname $upstreamPath)
      url="$urlPrefix/$upstreamPath"
      echo "  { url = \"$url\";"
      echo "    sha256 = \"$sha256\";"
      echo "    name = \"$name\";"
      echo "    mavenDir = \"$upstreamDir\";"
      echo "  }"
    done
  
    cat ${missingDeps}
    cat ${footer}
  '';

in pkgs.stdenv.mkDerivation {
  name = "${name}-deps.nix";

  phases = [ "buildPhase" "installPhase" ];

  buildPhase = ''
    ${gen-deps-script} > deps.nix
  '';
  
  installPhase = ''
    cp deps.nix $out
  '';
}
