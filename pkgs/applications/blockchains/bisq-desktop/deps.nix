{ stdenv, fetchurl, rsync }:
let
  package = { name, url, sha256, mavenDir }: 
    stdenv.mkDerivation {
      name = "bisq-dep-${name}";
      src = fetchurl { inherit url sha256; };

      unpackCmd = ''
        mkdir output 
        cp $curSrc "output/${name}"
      '';

      installPhase = ''
        mkdir -p "$out/${mavenDir}"
        cp -r . "$out/${mavenDir}/"
      '';
    };

  deps = map package [
  { url = "https://repo1.maven.org/maven2/com/google/gradle/osdetector-gradle-plugin/1.6.0/osdetector-gradle-plugin-1.6.0.pom";
    sha256 = "f6cd28bb7aa1b704faedf9b9a65d035476b9c6c3ca8cda5d7b76e0e3a22dcfd6";
    name = "osdetector-gradle-plugin-1.6.0.pom";
    mavenDir = "com/google/gradle/osdetector-gradle-plugin/1.6.0";
  }
  { url = "https://repo1.maven.org/maven2/com/google/gradle/osdetector-gradle-plugin/1.6.0/osdetector-gradle-plugin-1.6.0.jar";
    sha256 = "e074d3daa0ca0e5a0c6e2c98fcd9da6645ac520c8d091612ae58bdcde65d0585";
    name = "osdetector-gradle-plugin-1.6.0.jar";
    mavenDir = "com/google/gradle/osdetector-gradle-plugin/1.6.0";
  }
  { url = "https://repo1.maven.org/maven2/com/google/protobuf/protobuf-gradle-plugin/0.8.10/protobuf-gradle-plugin-0.8.10.pom";
    sha256 = "4af6c707ac7eacd0a50d07d43bd07c2609713d58cc7a44abbd1354136a723864";
    name = "protobuf-gradle-plugin-0.8.10.pom";
    mavenDir = "com/google/protobuf/protobuf-gradle-plugin/0.8.10";
  }
  { url = "https://repo1.maven.org/maven2/com/google/protobuf/protobuf-gradle-plugin/0.8.10/protobuf-gradle-plugin-0.8.10.jar";
    sha256 = "3287f2efd60a4d3ee8a95ea6d0cf5223507e231e8661c873f84aad5fcd79e1ef";
    name = "protobuf-gradle-plugin-0.8.10.jar";
    mavenDir = "com/google/protobuf/protobuf-gradle-plugin/0.8.10";
  }
  { url = "https://repo1.maven.org/maven2/com/google/protobuf/protobuf-java/3.10.0/protobuf-java-3.10.0.pom";
    sha256 = "b404c1b093ec9dea888e02c8dfe8662759586b94efa4f97061cdfc1bbfa15af0";
    name = "protobuf-java-3.10.0.pom";
    mavenDir = "com/google/protobuf/protobuf-java/3.10.0";
  }
  { url = "https://repo1.maven.org/maven2/com/google/protobuf/protobuf-java/3.10.0/protobuf-java-3.10.0.jar";
    sha256 = "161d7d61a8cb3970891c299578702fd079646e032329d6c2cabf998d191437c9";
    name = "protobuf-java-3.10.0.jar";
    mavenDir = "com/google/protobuf/protobuf-java/3.10.0";
  }
  { url = "https://repo1.maven.org/maven2/com/google/protobuf/protobuf-parent/3.10.0/protobuf-parent-3.10.0.pom";
    sha256 = "6dd84a508125fffdefbd583fae12bf166aa902511b570ca54fa9efa45f6dfe80";
    name = "protobuf-parent-3.10.0.pom";
    mavenDir = "com/google/protobuf/protobuf-parent/3.10.0";
  }
  { url = "https://repo1.maven.org/maven2/com/google/protobuf/protobuf-bom/3.10.0/protobuf-bom-3.10.0.pom";
    sha256 = "32ff2307dafc658d0b55b2ad841d625aea5606bb9b0316605165cd6980503243";
    name = "protobuf-bom-3.10.0.pom";
    mavenDir = "com/google/protobuf/protobuf-bom/3.10.0";
  }
  { url = "https://repo1.maven.org/maven2/com/google/guava/guava/18.0/guava-18.0.pom";
    sha256 = "e743d61d76f76b5dc060d6f7914fdd41c4418b3529062556920116a716719836";
    name = "guava-18.0.pom";
    mavenDir = "com/google/guava/guava/18.0";
  }
  { url = "https://repo1.maven.org/maven2/com/google/guava/guava/18.0/guava-18.0.jar";
    sha256 = "d664fbfc03d2e5ce9cab2a44fb01f1d0bf9dfebeccc1a473b1f9ea31f79f6f99";
    name = "guava-18.0.jar";
    mavenDir = "com/google/guava/guava/18.0";
  }
  { url = "https://repo1.maven.org/maven2/com/google/guava/guava/28.2-jre/guava-28.2-jre.pom";
    sha256 = "c0805261548dc61ca4c982b59bfaad6503e43190f5e5e444e90b2cf6ab72db94";
    name = "guava-28.2-jre.pom";
    mavenDir = "com/google/guava/guava/28.2-jre";
  }
  { url = "https://repo1.maven.org/maven2/com/google/guava/guava/28.2-jre/guava-28.2-jre.jar";
    sha256 = "fc3aa363ad87223d1fbea584eee015a862150f6d34c71f24dc74088a635f08ef";
    name = "guava-28.2-jre.jar";
    mavenDir = "com/google/guava/guava/28.2-jre";
  }
  { url = "https://repo1.maven.org/maven2/com/google/guava/guava-parent/18.0/guava-parent-18.0.pom";
    sha256 = "a4accc8895e757f6a33f087e4fd0b661c5638ffe5e0728f298efe7d80551b166";
    name = "guava-parent-18.0.pom";
    mavenDir = "com/google/guava/guava-parent/18.0";
  }
  { url = "https://repo1.maven.org/maven2/com/google/guava/guava-parent/28.2-jre/guava-parent-28.2-jre.pom";
    sha256 = "504a6d18eb81ba6d5a255a262bd823f0168c7f47814d4b524f5fa303ea5617c2";
    name = "guava-parent-28.2-jre.pom";
    mavenDir = "com/google/guava/guava-parent/28.2-jre";
  }
  { url = "https://repo1.maven.org/maven2/com/google/guava/guava-parent/26.0-android/guava-parent-26.0-android.pom";
    sha256 = "f8698ab46ca996ce889c1afc8ca4f25eb8ac6b034dc898d4583742360016cc04";
    name = "guava-parent-26.0-android.pom";
    mavenDir = "com/google/guava/guava-parent/26.0-android";
  }
  { url = "https://repo1.maven.org/maven2/com/google/guava/failureaccess/1.0.1/failureaccess-1.0.1.pom";
    sha256 = "e96042ce78fecba0da2be964522947c87b40a291b5fd3cd672a434924103c4b9";
    name = "failureaccess-1.0.1.pom";
    mavenDir = "com/google/guava/failureaccess/1.0.1";
  }
  { url = "https://repo1.maven.org/maven2/com/google/guava/failureaccess/1.0.1/failureaccess-1.0.1.jar";
    sha256 = "a171ee4c734dd2da837e4b16be9df4661afab72a41adaf31eb84dfdaf936ca26";
    name = "failureaccess-1.0.1.jar";
    mavenDir = "com/google/guava/failureaccess/1.0.1";
  }
  { url = "https://repo1.maven.org/maven2/com/google/guava/listenablefuture/9999.0-empty-to-avoid-conflict-with-guava/listenablefuture-9999.0-empty-to-avoid-conflict-with-guava.pom";
    sha256 = "18d4b1db26153d4e55079ce1f76bb1fe05cdb862ef9954a88cbcc4ff38b8679b";
    name = "listenablefuture-9999.0-empty-to-avoid-conflict-with-guava.pom";
    mavenDir = "com/google/guava/listenablefuture/9999.0-empty-to-avoid-conflict-with-guava";
  }
  { url = "https://repo1.maven.org/maven2/com/google/guava/listenablefuture/9999.0-empty-to-avoid-conflict-with-guava/listenablefuture-9999.0-empty-to-avoid-conflict-with-guava.jar";
    sha256 = "b372a037d4230aa57fbeffdef30fd6123f9c0c2db85d0aced00c91b974f33f99";
    name = "listenablefuture-9999.0-empty-to-avoid-conflict-with-guava.jar";
    mavenDir = "com/google/guava/listenablefuture/9999.0-empty-to-avoid-conflict-with-guava";
  }
  { url = "https://repo1.maven.org/maven2/com/google/code/findbugs/jsr305/3.0.2/jsr305-3.0.2.pom";
    sha256 = "19889dbdf1b254b2601a5ee645b8147a974644882297684c798afe5d63d78dfe";
    name = "jsr305-3.0.2.pom";
    mavenDir = "com/google/code/findbugs/jsr305/3.0.2";
  }
  { url = "https://repo1.maven.org/maven2/com/google/code/findbugs/jsr305/3.0.2/jsr305-3.0.2.jar";
    sha256 = "766ad2a0783f2687962c8ad74ceecc38a28b9f72a2d085ee438b7813e928d0c7";
    name = "jsr305-3.0.2.jar";
    mavenDir = "com/google/code/findbugs/jsr305/3.0.2";
  }
  { url = "https://repo1.maven.org/maven2/com/google/code/gson/gson/2.8.5/gson-2.8.5.pom";
    sha256 = "b8308557a7fccc92d9fe7c8cd0599258b361285d2ecde7689eda98843255a092";
    name = "gson-2.8.5.pom";
    mavenDir = "com/google/code/gson/gson/2.8.5";
  }
  { url = "https://repo1.maven.org/maven2/com/google/code/gson/gson/2.8.5/gson-2.8.5.jar";
    sha256 = "233a0149fc365c9f6edbd683cfe266b19bdc773be98eabdaf6b3c924b48e7d81";
    name = "gson-2.8.5.jar";
    mavenDir = "com/google/code/gson/gson/2.8.5";
  }
  { url = "https://repo1.maven.org/maven2/com/google/code/gson/gson-parent/2.8.5/gson-parent-2.8.5.pom";
    sha256 = "8f1fec72b91a71ea39ec39f5f778c4d1124b6b097c6d55b3a50b554a52237b27";
    name = "gson-parent-2.8.5.pom";
    mavenDir = "com/google/code/gson/gson-parent/2.8.5";
  }
  { url = "https://repo1.maven.org/maven2/com/google/zxing/javase/2.0/javase-2.0.pom";
    sha256 = "5715c1c41276eeb86793d061d8251f545442f567a920125eca7e71c54ca39bfa";
    name = "javase-2.0.pom";
    mavenDir = "com/google/zxing/javase/2.0";
  }
  { url = "https://repo1.maven.org/maven2/com/google/zxing/javase/2.0/javase-2.0.jar";
    sha256 = "0ec23e2ec12664ddd6347c8920ad647bb3b9da290f897a88516014b56cc77eb9";
    name = "javase-2.0.jar";
    mavenDir = "com/google/zxing/javase/2.0";
  }
  { url = "https://repo1.maven.org/maven2/com/google/zxing/core/2.0/core-2.0.pom";
    sha256 = "2bf92ca16394dbf2906b03c5d2c749f6c280b9289bdc469bb263590a117d9957";
    name = "core-2.0.pom";
    mavenDir = "com/google/zxing/core/2.0";
  }
  { url = "https://repo1.maven.org/maven2/com/google/zxing/core/2.0/core-2.0.jar";
    sha256 = "11aae8fd974ab25faa8208be50468eb12349cd239e93e7c797377fa13e381729";
    name = "core-2.0.jar";
    mavenDir = "com/google/zxing/core/2.0";
  }
  { url = "https://repo1.maven.org/maven2/com/google/errorprone/error_prone_annotations/2.3.4/error_prone_annotations-2.3.4.pom";
    sha256 = "1326738a4b4f7ccacf607b866a11fb85193ef60f6a59461187ce7265f9be5bed";
    name = "error_prone_annotations-2.3.4.pom";
    mavenDir = "com/google/errorprone/error_prone_annotations/2.3.4";
  }
  { url = "https://repo1.maven.org/maven2/com/google/errorprone/error_prone_annotations/2.3.4/error_prone_annotations-2.3.4.jar";
    sha256 = "baf7d6ea97ce606c53e11b6854ba5f2ce7ef5c24dddf0afa18d1260bd25b002c";
    name = "error_prone_annotations-2.3.4.jar";
    mavenDir = "com/google/errorprone/error_prone_annotations/2.3.4";
  }
  { url = "https://repo1.maven.org/maven2/com/google/errorprone/error_prone_parent/2.3.4/error_prone_parent-2.3.4.pom";
    sha256 = "40495b437a60d2398f0fdfc054b89d9c394a82347a274a0721c2e950a4302186";
    name = "error_prone_parent-2.3.4.pom";
    mavenDir = "com/google/errorprone/error_prone_parent/2.3.4";
  }
  { url = "https://repo1.maven.org/maven2/com/google/j2objc/j2objc-annotations/1.3/j2objc-annotations-1.3.pom";
    sha256 = "5faca824ba115bee458730337dfdb2fcea46ba2fd774d4304edbf30fa6a3f055";
    name = "j2objc-annotations-1.3.pom";
    mavenDir = "com/google/j2objc/j2objc-annotations/1.3";
  }
  { url = "https://repo1.maven.org/maven2/com/google/j2objc/j2objc-annotations/1.3/j2objc-annotations-1.3.jar";
    sha256 = "21af30c92267bd6122c0e0b4d20cccb6641a37eaf956c6540ec471d584e64a7b";
    name = "j2objc-annotations-1.3.jar";
    mavenDir = "com/google/j2objc/j2objc-annotations/1.3";
  }
  { url = "https://repo1.maven.org/maven2/com/google/api/grpc/proto-google-common-protos/1.12.0/proto-google-common-protos-1.12.0.pom";
    sha256 = "1562bd44df27231d5eb1641625df72b0fe13e29feeaf55527c85e617decf0e3a";
    name = "proto-google-common-protos-1.12.0.pom";
    mavenDir = "com/google/api/grpc/proto-google-common-protos/1.12.0";
  }
  { url = "https://repo1.maven.org/maven2/com/google/api/grpc/proto-google-common-protos/1.12.0/proto-google-common-protos-1.12.0.jar";
    sha256 = "bd60cd7a423b00fb824c27bdd0293aaf4781be1daba6ed256311103fb4b84108";
    name = "proto-google-common-protos-1.12.0.jar";
    mavenDir = "com/google/api/grpc/proto-google-common-protos/1.12.0";
  }
  { url = "https://repo1.maven.org/maven2/com/google/inject/guice/4.2.2/guice-4.2.2.pom";
    sha256 = "06f3c3ddad57b30bfe88655456a04731e56a78ad0dd909e65c71881003b96479";
    name = "guice-4.2.2.pom";
    mavenDir = "com/google/inject/guice/4.2.2";
  }
  { url = "https://repo1.maven.org/maven2/com/google/inject/guice/4.2.2/guice-4.2.2.jar";
    sha256 = "d258ff1bd9b8b527872f8402648226658ad3149f1f40e74b0566d69e7e042fbc";
    name = "guice-4.2.2.jar";
    mavenDir = "com/google/inject/guice/4.2.2";
  }
  { url = "https://repo1.maven.org/maven2/com/google/inject/guice-parent/4.2.2/guice-parent-4.2.2.pom";
    sha256 = "5a74ba3d22be1ac13b9e782f13a7d957db2a24ded359481394c9e889f1c037d6";
    name = "guice-parent-4.2.2.pom";
    mavenDir = "com/google/inject/guice-parent/4.2.2";
  }
  { url = "https://repo1.maven.org/maven2/com/google/google/5/google-5.pom";
    sha256 = "e09d345e73ca3fbca7f3e05f30deb74e9d39dd6b79a93fee8c511f23417b6828";
    name = "google-5.pom";
    mavenDir = "com/google/google/5";
  }
  { url = "https://repo1.maven.org/maven2/com/google/android/annotations/4.1.1.4/annotations-4.1.1.4.pom";
    sha256 = "e4bb54753c36a27a0e5d70154a5034fedd8feac4282295034bfd483d6c7aae78";
    name = "annotations-4.1.1.4.pom";
    mavenDir = "com/google/android/annotations/4.1.1.4";
  }
  { url = "https://repo1.maven.org/maven2/com/google/android/annotations/4.1.1.4/annotations-4.1.1.4.jar";
    sha256 = "ba734e1e84c09d615af6a09d33034b4f0442f8772dec120efb376d86a565ae15";
    name = "annotations-4.1.1.4.jar";
    mavenDir = "com/google/android/annotations/4.1.1.4";
  }
  { url = "https://plugins.gradle.org/m2/com/github/jengelman/gradle/plugins/shadow/5.2.0/shadow-5.2.0.pom";
    sha256 = "1yc8rwqnwj7j0gagdgyglchbg9jrjg6rcknadns68s6iym68yijl";
    name = "shadow-5.2.0.pom";
    mavenDir = "com/github/jengelman/gradle/plugins/shadow/5.2.0";
  }
  { url = "https://plugins.gradle.org/m2/com/github/jengelman/gradle/plugins/shadow/5.2.0/shadow-5.2.0.jar";
    sha256 = "1j56ddyj71jvaypwhgz25nxh5ffsa58ykwp16pscw6pisrkdlj5p";
    name = "shadow-5.2.0.jar";
    mavenDir = "com/github/jengelman/gradle/plugins/shadow/5.2.0";
  }
  { url = "https://repo1.maven.org/maven2/com/github/sarxos/webcam-capture/0.3.12/webcam-capture-0.3.12.pom";
    sha256 = "f6f6d9e8d04fed809a295589475d3faa5db5cc2cfb2d093c1941dd63e1e04e41";
    name = "webcam-capture-0.3.12.pom";
    mavenDir = "com/github/sarxos/webcam-capture/0.3.12";
  }
  { url = "https://repo1.maven.org/maven2/com/github/sarxos/webcam-capture/0.3.12/webcam-capture-0.3.12.jar";
    sha256 = "d960b7ea8ec3ddf2df0725ef214c3fccc9699ea7772df37f544e1f8e4fd665f6";
    name = "webcam-capture-0.3.12.jar";
    mavenDir = "com/github/sarxos/webcam-capture/0.3.12";
  }
  { url = "https://repo1.maven.org/maven2/com/github/sarxos/webcam-capture-parent/0.3.12/webcam-capture-parent-0.3.12.pom";
    sha256 = "ced0bcd6b053b079f7bb0a7660d489be326ad50e21ffe3c4ccf04357ff669939";
    name = "webcam-capture-parent-0.3.12.pom";
    mavenDir = "com/github/sarxos/webcam-capture-parent/0.3.12";
  }
  { url = "https://repo1.maven.org/maven2/com/github/sarxos/oss-parent/4/oss-parent-4.pom";
    sha256 = "526059424e14c23b97b379aaf0ed7519ba1d37b8dbd12e4944571dbfb146bfa4";
    name = "oss-parent-4.pom";
    mavenDir = "com/github/sarxos/oss-parent/4";
  }
  { url = "https://repo1.maven.org/maven2/com/fasterxml/jackson/jackson-bom/2.8.10/jackson-bom-2.8.10.pom";
    sha256 = "e98f0216409651cd0a1a4ef0224039fd25cae0d4ee7f58fc73b0c1fd0e38b323";
    name = "jackson-bom-2.8.10.pom";
    mavenDir = "com/fasterxml/jackson/jackson-bom/2.8.10";
  }
  { url = "https://repo1.maven.org/maven2/com/fasterxml/jackson/jackson-parent/2.8/jackson-parent-2.8.pom";
    sha256 = "3b51994c1a3a29c2c89728226c0be14b69888a1bb0ef311f8d65904cdfbd9358";
    name = "jackson-parent-2.8.pom";
    mavenDir = "com/fasterxml/jackson/jackson-parent/2.8";
  }
  { url = "https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-core/2.8.10/jackson-core-2.8.10.pom";
    sha256 = "ba259a91a34176afc3b82b8d7cb6a5bea0222a8de331df80033197d4f398c3c5";
    name = "jackson-core-2.8.10.pom";
    mavenDir = "com/fasterxml/jackson/core/jackson-core/2.8.10";
  }
  { url = "https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-core/2.8.10/jackson-core-2.8.10.jar";
    sha256 = "39a74610521d7fb9eb3f437bb8739bbf47f6435be12d17bf954c731a0c6352bb";
    name = "jackson-core-2.8.10.jar";
    mavenDir = "com/fasterxml/jackson/core/jackson-core/2.8.10";
  }
  { url = "https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-annotations/2.8.10/jackson-annotations-2.8.10.pom";
    sha256 = "d46bbd247be429654e6ddb24f7827ffca96547e036a3174b999eb74d5be40665";
    name = "jackson-annotations-2.8.10.pom";
    mavenDir = "com/fasterxml/jackson/core/jackson-annotations/2.8.10";
  }
  { url = "https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-annotations/2.8.10/jackson-annotations-2.8.10.jar";
    sha256 = "2566b3a6662afa3c6af4f5b25006cb46be2efc68f1b5116291d6998a8cdf7ed3";
    name = "jackson-annotations-2.8.10.jar";
    mavenDir = "com/fasterxml/jackson/core/jackson-annotations/2.8.10";
  }
  { url = "https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-databind/2.8.10/jackson-databind-2.8.10.pom";
    sha256 = "b8f0fa5b70dd9c904e43967ebf7ca008d49862127c015256a665c71e2f9def5e";
    name = "jackson-databind-2.8.10.pom";
    mavenDir = "com/fasterxml/jackson/core/jackson-databind/2.8.10";
  }
  { url = "https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-databind/2.8.10/jackson-databind-2.8.10.jar";
    sha256 = "fcf3c2b0c332f5f54604f7e27fa7ee502378a2cc5df6a944bbfae391872c32ff";
    name = "jackson-databind-2.8.10.jar";
    mavenDir = "com/fasterxml/jackson/core/jackson-databind/2.8.10";
  }
  { url = "https://repo1.maven.org/maven2/com/fasterxml/oss-parent/27/oss-parent-27.pom";
    sha256 = "b9b8f388fd628057b1249756468b86726c8fd5816ce14d313cb40003a509beeb";
    name = "oss-parent-27.pom";
    mavenDir = "com/fasterxml/oss-parent/27";
  }
  { url = "https://repo1.maven.org/maven2/com/jfoenix/jfoenix/9.0.6/jfoenix-9.0.6.pom";
    sha256 = "cd59fd3873f7d417906882a0a3306cb1771fbc1262dcf0494a5a1d0342c3896f";
    name = "jfoenix-9.0.6.pom";
    mavenDir = "com/jfoenix/jfoenix/9.0.6";
  }
  { url = "https://repo1.maven.org/maven2/com/jfoenix/jfoenix/9.0.6/jfoenix-9.0.6.jar";
    sha256 = "4739e37a05e67c3bc9d5b391a1b93717b5a48fa872992616b0964d3f827f8fe6";
    name = "jfoenix-9.0.6.jar";
    mavenDir = "com/jfoenix/jfoenix/9.0.6";
  }
  { url = "https://repo1.maven.org/maven2/com/googlecode/jcsv/jcsv/1.4.0/jcsv-1.4.0.pom";
    sha256 = "5788f3fa57cd4cb75db096d5286b948c8a8cb8897875759eda653a29758289d6";
    name = "jcsv-1.4.0.pom";
    mavenDir = "com/googlecode/jcsv/jcsv/1.4.0";
  }
  { url = "https://repo1.maven.org/maven2/com/googlecode/jcsv/jcsv/1.4.0/jcsv-1.4.0.jar";
    sha256 = "73ca7d715e90c8d2c2635cc284543b038245a34f70790660ed590e157b8714a2";
    name = "jcsv-1.4.0.jar";
    mavenDir = "com/googlecode/jcsv/jcsv/1.4.0";
  }
  { url = "https://repo1.maven.org/maven2/com/nativelibs4java/bridj/0.7.0/bridj-0.7.0.pom";
    sha256 = "748756b9562a771afdd09dba6e863cefcf870596ebb26d8d7bcb3434ccb5e405";
    name = "bridj-0.7.0.pom";
    mavenDir = "com/nativelibs4java/bridj/0.7.0";
  }
  { url = "https://repo1.maven.org/maven2/com/nativelibs4java/bridj/0.7.0/bridj-0.7.0.jar";
    sha256 = "101bcd9b6637e6bc16e56deb3daefba62b1f5e8e9e37e1b3e56e3b5860d659cf";
    name = "bridj-0.7.0.jar";
    mavenDir = "com/nativelibs4java/bridj/0.7.0";
  }
  { url = "https://repo1.maven.org/maven2/com/nativelibs4java/nativelibs4java-parent/1.9/nativelibs4java-parent-1.9.pom";
    sha256 = "12132a77ca914b88215d58e5ffcc428dd7742983c595df8e9d4de02eb2e562ca";
    name = "nativelibs4java-parent-1.9.pom";
    mavenDir = "com/nativelibs4java/nativelibs4java-parent/1.9";
  }
  { url = "https://repo1.maven.org/maven2/org/springframework/boot/spring-boot-gradle-plugin/1.5.10.RELEASE/spring-boot-gradle-plugin-1.5.10.RELEASE.pom";
    sha256 = "5b880e822cf3e00758c29bd1f2199977b28c7b677e0dcc0101b1530387418279";
    name = "spring-boot-gradle-plugin-1.5.10.RELEASE.pom";
    mavenDir = "org/springframework/boot/spring-boot-gradle-plugin/1.5.10.RELEASE";
  }
  { url = "https://repo1.maven.org/maven2/org/springframework/boot/spring-boot-gradle-plugin/1.5.10.RELEASE/spring-boot-gradle-plugin-1.5.10.RELEASE.jar";
    sha256 = "f430e1db7b8746c6feeee5cc8b5ff664e0fae3b760983d0a35d71642997f974d";
    name = "spring-boot-gradle-plugin-1.5.10.RELEASE.jar";
    mavenDir = "org/springframework/boot/spring-boot-gradle-plugin/1.5.10.RELEASE";
  }
  { url = "https://repo1.maven.org/maven2/org/springframework/boot/spring-boot-tools/1.5.10.RELEASE/spring-boot-tools-1.5.10.RELEASE.pom";
    sha256 = "dc11c1c0da5d199cb5daf801bb51f0e3888ac606cbc25e8930a88657b48afef4";
    name = "spring-boot-tools-1.5.10.RELEASE.pom";
    mavenDir = "org/springframework/boot/spring-boot-tools/1.5.10.RELEASE";
  }
  { url = "https://repo1.maven.org/maven2/org/springframework/boot/spring-boot-parent/1.5.10.RELEASE/spring-boot-parent-1.5.10.RELEASE.pom";
    sha256 = "2eb05ff3c2c52ce028248e0f04b83456e16bbac108015fdc4465e91eb77bb539";
    name = "spring-boot-parent-1.5.10.RELEASE.pom";
    mavenDir = "org/springframework/boot/spring-boot-parent/1.5.10.RELEASE";
  }
  { url = "https://repo1.maven.org/maven2/org/springframework/boot/spring-boot-dependencies/1.5.10.RELEASE/spring-boot-dependencies-1.5.10.RELEASE.pom";
    sha256 = "aa82386c27e7548624edcc4812ab7115aa9cec15d6716ab4280f3a79791554b3";
    name = "spring-boot-dependencies-1.5.10.RELEASE.pom";
    mavenDir = "org/springframework/boot/spring-boot-dependencies/1.5.10.RELEASE";
  }
  { url = "https://repo1.maven.org/maven2/org/springframework/boot/spring-boot-loader-tools/1.5.10.RELEASE/spring-boot-loader-tools-1.5.10.RELEASE.pom";
    sha256 = "7705fe959a55129d52a6e7f1b2a13d0bd7209588261b7adb310502f103da202b";
    name = "spring-boot-loader-tools-1.5.10.RELEASE.pom";
    mavenDir = "org/springframework/boot/spring-boot-loader-tools/1.5.10.RELEASE";
  }
  { url = "https://repo1.maven.org/maven2/org/springframework/boot/spring-boot-loader-tools/1.5.10.RELEASE/spring-boot-loader-tools-1.5.10.RELEASE.jar";
    sha256 = "32ac263748bbc6a128c732402579f26849b37d62e0ef4c457c34dfceea0bfc71";
    name = "spring-boot-loader-tools-1.5.10.RELEASE.jar";
    mavenDir = "org/springframework/boot/spring-boot-loader-tools/1.5.10.RELEASE";
  }
  { url = "https://repo1.maven.org/maven2/org/springframework/spring-framework-bom/4.3.14.RELEASE/spring-framework-bom-4.3.14.RELEASE.pom";
    sha256 = "3bb35a75ac3723622bbe1c134595697665384ad3c27c5831619ffa78deec0f20";
    name = "spring-framework-bom-4.3.14.RELEASE.pom";
    mavenDir = "org/springframework/spring-framework-bom/4.3.14.RELEASE";
  }
  { url = "https://repo1.maven.org/maven2/org/springframework/spring-core/4.3.14.RELEASE/spring-core-4.3.14.RELEASE.pom";
    sha256 = "b6919ef5b3f29b82d584be03b73dcfa8a626f9c229c785962db979ed79796e66";
    name = "spring-core-4.3.14.RELEASE.pom";
    mavenDir = "org/springframework/spring-core/4.3.14.RELEASE";
  }
  { url = "https://repo1.maven.org/maven2/org/springframework/spring-core/4.3.14.RELEASE/spring-core-4.3.14.RELEASE.jar";
    sha256 = "461e35d0dd65e7dedcc9ce5dfc88692768d02216c33d9abe9cac50b5671e1480";
    name = "spring-core-4.3.14.RELEASE.jar";
    mavenDir = "org/springframework/spring-core/4.3.14.RELEASE";
  }
  { url = "https://repo1.maven.org/maven2/org/springframework/data/spring-data-releasetrain/Ingalls-SR10/spring-data-releasetrain-Ingalls-SR10.pom";
    sha256 = "c2134ef9e68da1969002d0e68a22801f096f393c255e99662a4145dc217f134e";
    name = "spring-data-releasetrain-Ingalls-SR10.pom";
    mavenDir = "org/springframework/data/spring-data-releasetrain/Ingalls-SR10";
  }
  { url = "https://repo1.maven.org/maven2/org/springframework/data/build/spring-data-build/1.9.10.RELEASE/spring-data-build-1.9.10.RELEASE.pom";
    sha256 = "284ed757469a0e11395067dd42f6ad6761bbae0a6d192a5188282a1b6e3857ef";
    name = "spring-data-build-1.9.10.RELEASE.pom";
    mavenDir = "org/springframework/data/build/spring-data-build/1.9.10.RELEASE";
  }
  { url = "https://repo1.maven.org/maven2/org/springframework/integration/spring-integration-bom/4.3.14.RELEASE/spring-integration-bom-4.3.14.RELEASE.pom";
    sha256 = "99072cdcd131b9c43109482d9806bde1e0380cfceb919acd79c4c420083e7ba9";
    name = "spring-integration-bom-4.3.14.RELEASE.pom";
    mavenDir = "org/springframework/integration/spring-integration-bom/4.3.14.RELEASE";
  }
  { url = "https://repo1.maven.org/maven2/org/springframework/security/spring-security-bom/4.2.4.RELEASE/spring-security-bom-4.2.4.RELEASE.pom";
    sha256 = "1d00dfa7a1804ce9875fb8f6c6b29293f05e4f56a020baf164fdc1187239ce77";
    name = "spring-security-bom-4.2.4.RELEASE.pom";
    mavenDir = "org/springframework/security/spring-security-bom/4.2.4.RELEASE";
  }
  { url = "https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-bom/2.7/log4j-bom-2.7.pom";
    sha256 = "d8c09f52c7bfabfe51680e63c5d4aa1e2c1d2313ad8c3532e75159cb47d40256";
    name = "log4j-bom-2.7.pom";
    mavenDir = "org/apache/logging/log4j/log4j-bom/2.7";
  }
  { url = "https://repo1.maven.org/maven2/org/apache/apache/9/apache-9.pom";
    sha256 = "4946e60a547c8eda69f3bc23c5b6f0dadcf8469ea49b1d1da7de34aecfcf18dd";
    name = "apache-9.pom";
    mavenDir = "org/apache/apache/9";
  }
  { url = "https://repo1.maven.org/maven2/org/apache/apache/7/apache-7.pom";
    sha256 = "1397ce1db433adc9f223dbf07496d133681448751f4ae29e58f68e78fb4b6c25";
    name = "apache-7.pom";
    mavenDir = "org/apache/apache/7";
  }
  { url = "https://repo1.maven.org/maven2/org/apache/apache/13/apache-13.pom";
    sha256 = "ff513db0361fd41237bef4784968bc15aae478d4ec0a9496f811072ccaf3841d";
    name = "apache-13.pom";
    mavenDir = "org/apache/apache/13";
  }
  { url = "https://repo1.maven.org/maven2/org/apache/apache/21/apache-21.pom";
    sha256 = "af10c108da014f17cafac7b52b2b4b5a3a1c18265fa2af97a325d9143537b380";
    name = "apache-21.pom";
    mavenDir = "org/apache/apache/21";
  }
  { url = "https://repo1.maven.org/maven2/org/apache/apache/19/apache-19.pom";
    sha256 = "91f7a33096ea69bac2cbaf6d01feb934cac002c48d8c8cfa9c240b40f1ec21df";
    name = "apache-19.pom";
    mavenDir = "org/apache/apache/19";
  }
  { url = "https://repo1.maven.org/maven2/org/apache/apache/18/apache-18.pom";
    sha256 = "7831307285fd475bbc36b20ae38e7882f11c3153b1d5930f852d44eda8f33c17";
    name = "apache-18.pom";
    mavenDir = "org/apache/apache/18";
  }
  { url = "https://repo1.maven.org/maven2/org/apache/commons/commons-parent/17/commons-parent-17.pom";
    sha256 = "96e718baf534874ee62ce4d42de265f2ddacd88391a540e030d59d98fa7c4408";
    name = "commons-parent-17.pom";
    mavenDir = "org/apache/commons/commons-parent/17";
  }
  { url = "https://repo1.maven.org/maven2/org/apache/commons/commons-parent/34/commons-parent-34.pom";
    sha256 = "3a2e69d06d641d1f3b293126dc9e2e4ea6563bf8c36c87e0ab6fa4292d04b79c";
    name = "commons-parent-34.pom";
    mavenDir = "org/apache/commons/commons-parent/34";
  }
  { url = "https://repo1.maven.org/maven2/org/apache/commons/commons-parent/48/commons-parent-48.pom";
    sha256 = "1e1f7de9370a7b7901f128f1dacd1422be74e3f47f9558b0f79e04c0637ca0b4";
    name = "commons-parent-48.pom";
    mavenDir = "org/apache/commons/commons-parent/48";
  }
  { url = "https://repo1.maven.org/maven2/org/apache/commons/commons-parent/47/commons-parent-47.pom";
    sha256 = "8a8ecb570553bf9f1ffae211a8d4ca9ee630c17afe59293368fba7bd9b42fcb7";
    name = "commons-parent-47.pom";
    mavenDir = "org/apache/commons/commons-parent/47";
  }
  { url = "https://repo1.maven.org/maven2/org/apache/commons/commons-parent/42/commons-parent-42.pom";
    sha256 = "cd313494c670b483ec256972af1698b330e598f807002354eb765479f604b09c";
    name = "commons-parent-42.pom";
    mavenDir = "org/apache/commons/commons-parent/42";
  }
  { url = "https://repo1.maven.org/maven2/org/apache/commons/commons-lang3/3.8/commons-lang3-3.8.pom";
    sha256 = "0bbb97a8515cf9a6fba6b754a649c3849fad67aa5af8be5c34abb2015177531f";
    name = "commons-lang3-3.8.pom";
    mavenDir = "org/apache/commons/commons-lang3/3.8";
  }
  { url = "https://repo1.maven.org/maven2/org/apache/commons/commons-lang3/3.8/commons-lang3-3.8.jar";
    sha256 = "9375aad1000cdd5bd3068e832de9802094fac1f145655251e141d5d0072fab9a";
    name = "commons-lang3-3.8.jar";
    mavenDir = "org/apache/commons/commons-lang3/3.8";
  }
  { url = "https://repo1.maven.org/maven2/org/apache/commons/commons-compress/1.18/commons-compress-1.18.pom";
    sha256 = "672c5fe92bd3eab43e8d53338cad5ca073b6529de4eb2b38859a3eaa6c9e8119";
    name = "commons-compress-1.18.pom";
    mavenDir = "org/apache/commons/commons-compress/1.18";
  }
  { url = "https://repo1.maven.org/maven2/org/apache/commons/commons-compress/1.18/commons-compress-1.18.jar";
    sha256 = "5f2df1e467825e4cac5996d44890c4201c000b43c0b23cffc0782d28a0beb9b0";
    name = "commons-compress-1.18.jar";
    mavenDir = "org/apache/commons/commons-compress/1.18";
  }
  { url = "https://repo1.maven.org/maven2/org/apache/httpcomponents/httpclient/4.5.12/httpclient-4.5.12.pom";
    sha256 = "419ad1b24a77baa2288ab60ae057b4cf78dbc2c11d27c7204d5cb6779a451527";
    name = "httpclient-4.5.12.pom";
    mavenDir = "org/apache/httpcomponents/httpclient/4.5.12";
  }
  { url = "https://repo1.maven.org/maven2/org/apache/httpcomponents/httpclient/4.5.12/httpclient-4.5.12.jar";
    sha256 = "bc5f065aba5dd815ee559dd24d9bcb797fb102ff9cfa036f5091ebc529bd3b93";
    name = "httpclient-4.5.12.jar";
    mavenDir = "org/apache/httpcomponents/httpclient/4.5.12";
  }
  { url = "https://repo1.maven.org/maven2/org/apache/httpcomponents/httpcore/4.4.13/httpcore-4.4.13.pom";
    sha256 = "8f812d9fa7b72a3d4aa7f825278932a5df344b42a6d8398905879431a1bf9a97";
    name = "httpcore-4.4.13.pom";
    mavenDir = "org/apache/httpcomponents/httpcore/4.4.13";
  }
  { url = "https://repo1.maven.org/maven2/org/apache/httpcomponents/httpcore/4.4.13/httpcore-4.4.13.jar";
    sha256 = "e06e89d40943245fcfa39ec537cdbfce3762aecde8f9c597780d2b00c2b43424";
    name = "httpcore-4.4.13.jar";
    mavenDir = "org/apache/httpcomponents/httpcore/4.4.13";
  }
  { url = "https://repo1.maven.org/maven2/org/apache/httpcomponents/httpcomponents-core/4.4.13/httpcomponents-core-4.4.13.pom";
    sha256 = "c554e7008e4517c7ef54e005cc8b74f4c87a54a0ea2c6f57be5d0569df51936b";
    name = "httpcomponents-core-4.4.13.pom";
    mavenDir = "org/apache/httpcomponents/httpcomponents-core/4.4.13";
  }
  { url = "https://repo1.maven.org/maven2/org/apache/httpcomponents/httpcomponents-client/4.5.12/httpcomponents-client-4.5.12.pom";
    sha256 = "8f889a53593c027bea003fdbe89399546d7beefa1f60e1756015f10f502b016a";
    name = "httpcomponents-client-4.5.12.pom";
    mavenDir = "org/apache/httpcomponents/httpcomponents-client/4.5.12";
  }
  { url = "https://repo1.maven.org/maven2/org/apache/httpcomponents/httpcomponents-parent/11/httpcomponents-parent-11.pom";
    sha256 = "a901f87b115c55070c7ee43efff63e20e7b02d30af2443ae292bf1f4e532d3aa";
    name = "httpcomponents-parent-11.pom";
    mavenDir = "org/apache/httpcomponents/httpcomponents-parent/11";
  }
  { url = "https://repo1.maven.org/maven2/org/sonatype/oss/oss-parent/7/oss-parent-7.pom";
    sha256 = "b51f8867c92b6a722499557fc3a1fdea77bdf9ef574722fe90ce436a29559454";
    name = "oss-parent-7.pom";
    mavenDir = "org/sonatype/oss/oss-parent/7";
  }
  { url = "https://repo1.maven.org/maven2/org/sonatype/oss/oss-parent/9/oss-parent-9.pom";
    sha256 = "fb40265f982548212ff82e362e59732b2187ec6f0d80182885c14ef1f982827a";
    name = "oss-parent-9.pom";
    mavenDir = "org/sonatype/oss/oss-parent/9";
  }
  { url = "https://repo1.maven.org/maven2/org/codehaus/groovy/groovy-backports-compat23/2.4.15/groovy-backports-compat23-2.4.15.pom";
    sha256 = "badfde7591686a840a2dcb4b22a2d84b0633d2fdad3291c443e819eaea39dd23";
    name = "groovy-backports-compat23-2.4.15.pom";
    mavenDir = "org/codehaus/groovy/groovy-backports-compat23/2.4.15";
  }
  { url = "https://repo1.maven.org/maven2/org/codehaus/groovy/groovy-backports-compat23/2.4.15/groovy-backports-compat23-2.4.15.jar";
    sha256 = "434d2bfce7b3b16abebc2590832cc042ebd8898eaa39df0f9192c98f2e843766";
    name = "groovy-backports-compat23-2.4.15.jar";
    mavenDir = "org/codehaus/groovy/groovy-backports-compat23/2.4.15";
  }
  { url = "https://repo1.maven.org/maven2/org/openjfx/javafx-fxml/11.0.2/javafx-fxml-11.0.2.pom";
    sha256 = "86a63c3d730847a926004437628b161fcf065e3d2faf34a3c138cae23dc50f18";
    name = "javafx-fxml-11.0.2.pom";
    mavenDir = "org/openjfx/javafx-fxml/11.0.2";
  }
  { url = "https://repo1.maven.org/maven2/org/openjfx/javafx-fxml/11.0.2/javafx-fxml-11.0.2-linux.jar";
    sha256 = "22c44b25bc588df6623e04fa127b8bc82423f1f948e9aff2485af4a6890e2f94";
    name = "javafx-fxml-11.0.2-linux.jar";
    mavenDir = "org/openjfx/javafx-fxml/11.0.2";
  }
  { url = "https://repo1.maven.org/maven2/org/openjfx/javafx-controls/11.0.2/javafx-controls-11.0.2.pom";
    sha256 = "588e61c5bae81d09760b60d8cfb13b111b42d3d470c0a0a99da06ab6afd78d03";
    name = "javafx-controls-11.0.2.pom";
    mavenDir = "org/openjfx/javafx-controls/11.0.2";
  }
  { url = "https://repo1.maven.org/maven2/org/openjfx/javafx-controls/11.0.2/javafx-controls-11.0.2.jar";
    sha256 = "60106c2cf52a7f31eca1b8d08a952cf4b93b5b1d85492a755e97a0808a69ff9a";
    name = "javafx-controls-11.0.2.jar";
    mavenDir = "org/openjfx/javafx-controls/11.0.2";
  }
  { url = "https://repo1.maven.org/maven2/org/openjfx/javafx-controls/11.0.2/javafx-controls-11.0.2-linux.jar";
    sha256 = "c172042cf4ce77fc689fad6559256b11b99c6fb89ce5fd1b33dfc344b86a0a97";
    name = "javafx-controls-11.0.2-linux.jar";
    mavenDir = "org/openjfx/javafx-controls/11.0.2";
  }
  { url = "https://repo1.maven.org/maven2/org/openjfx/javafx-swing/11.0.2/javafx-swing-11.0.2.pom";
    sha256 = "86ebe526581be63786de12713cc14bdb7c15030ccf69c8c9ee596ec3252d07b3";
    name = "javafx-swing-11.0.2.pom";
    mavenDir = "org/openjfx/javafx-swing/11.0.2";
  }
  { url = "https://repo1.maven.org/maven2/org/openjfx/javafx-swing/11.0.2/javafx-swing-11.0.2-linux.jar";
    sha256 = "e562dbdad05b2864e8dc5ef9721b0c9a2cb173159da4496a2782b8cd1e65b14c";
    name = "javafx-swing-11.0.2-linux.jar";
    mavenDir = "org/openjfx/javafx-swing/11.0.2";
  }
  { url = "https://repo1.maven.org/maven2/org/openjfx/javafx/11.0.2/javafx-11.0.2.pom";
    sha256 = "bc67f03d0d95b175114a98efffb13e44e46ad9e3ac19eff0e8e063a6e7675ad8";
    name = "javafx-11.0.2.pom";
    mavenDir = "org/openjfx/javafx/11.0.2";
  }
  { url = "https://repo1.maven.org/maven2/org/openjfx/javafx-graphics/11.0.2/javafx-graphics-11.0.2.pom";
    sha256 = "e4edfea2cd9635adc92d3a9ba7cd5ec3a56ab1b17ea4a2560d122bfbdee053c8";
    name = "javafx-graphics-11.0.2.pom";
    mavenDir = "org/openjfx/javafx-graphics/11.0.2";
  }
  { url = "https://repo1.maven.org/maven2/org/openjfx/javafx-graphics/11.0.2/javafx-graphics-11.0.2.jar";
    sha256 = "dee900a186a70bae8266845c56b03ad9a24e697cb52ba3da421c6049089b3638";
    name = "javafx-graphics-11.0.2.jar";
    mavenDir = "org/openjfx/javafx-graphics/11.0.2";
  }
  { url = "https://repo1.maven.org/maven2/org/openjfx/javafx-graphics/11.0.2/javafx-graphics-11.0.2-linux.jar";
    sha256 = "fb209564e50de3d8d055d9b3cd69d46a16d3ef18ec55162fc1300d1408a9d502";
    name = "javafx-graphics-11.0.2-linux.jar";
    mavenDir = "org/openjfx/javafx-graphics/11.0.2";
  }
  { url = "https://repo1.maven.org/maven2/org/openjfx/javafx-base/11.0.2/javafx-base-11.0.2.pom";
    sha256 = "17f41668850b803ba4a83a7e2d96039b69f072788bbdba88e09fec8157a0329c";
    name = "javafx-base-11.0.2.pom";
    mavenDir = "org/openjfx/javafx-base/11.0.2";
  }
  { url = "https://repo1.maven.org/maven2/org/openjfx/javafx-base/11.0.2/javafx-base-11.0.2.jar";
    sha256 = "1f2f88898f54f1a29e2b58caaeb0a11050598a07524f296cd9aef6c00bb93d0f";
    name = "javafx-base-11.0.2.jar";
    mavenDir = "org/openjfx/javafx-base/11.0.2";
  }
  { url = "https://repo1.maven.org/maven2/org/openjfx/javafx-base/11.0.2/javafx-base-11.0.2-linux.jar";
    sha256 = "84c356f1344bfd3aa74b55a23a0ce078b4c5e6a9be8853da8de415e5ecfcd41b";
    name = "javafx-base-11.0.2-linux.jar";
    mavenDir = "org/openjfx/javafx-base/11.0.2";
  }
  { url = "https://repo1.maven.org/maven2/org/checkerframework/checker-qual/2.10.0/checker-qual-2.10.0.pom";
    sha256 = "246e47e395f8d7a8c12b7222b166bc3a1d3809bc3a3d30de97470aa38d952a4b";
    name = "checker-qual-2.10.0.pom";
    mavenDir = "org/checkerframework/checker-qual/2.10.0";
  }
  { url = "https://repo1.maven.org/maven2/org/checkerframework/checker-qual/2.10.0/checker-qual-2.10.0.jar";
    sha256 = "d261fde25d590f6b69db7721d469ac1b0a19a17ccaaaa751c31f0d8b8260b894";
    name = "checker-qual-2.10.0.jar";
    mavenDir = "org/checkerframework/checker-qual/2.10.0";
  }
  { url = "https://repo1.maven.org/maven2/org/slf4j/slf4j-api/1.7.2/slf4j-api-1.7.2.pom";
    sha256 = "2eaca71afe0a1516f4abd8e9ff907838d268f38c81c3a542cce8d7f3b87c5d4c";
    name = "slf4j-api-1.7.2.pom";
    mavenDir = "org/slf4j/slf4j-api/1.7.2";
  }
  { url = "https://repo1.maven.org/maven2/org/slf4j/slf4j-api/1.7.30/slf4j-api-1.7.30.pom";
    sha256 = "7e0747751e9b67e19dcb5206f04ea22cc03d250c422426402eadd03513f2c314";
    name = "slf4j-api-1.7.30.pom";
    mavenDir = "org/slf4j/slf4j-api/1.7.30";
  }
  { url = "https://repo1.maven.org/maven2/org/slf4j/slf4j-api/1.7.30/slf4j-api-1.7.30.jar";
    sha256 = "cdba07964d1bb40a0761485c6b1e8c2f8fd9eb1d19c53928ac0d7f9510105c57";
    name = "slf4j-api-1.7.30.jar";
    mavenDir = "org/slf4j/slf4j-api/1.7.30";
  }
  { url = "https://repo1.maven.org/maven2/org/slf4j/slf4j-parent/1.7.2/slf4j-parent-1.7.2.pom";
    sha256 = "1d8e084a6f2384ade42685332b52a0ece090478641dc14c0fa8c52e1e2984425";
    name = "slf4j-parent-1.7.2.pom";
    mavenDir = "org/slf4j/slf4j-parent/1.7.2";
  }
  { url = "https://repo1.maven.org/maven2/org/slf4j/slf4j-parent/1.7.30/slf4j-parent-1.7.30.pom";
    sha256 = "11647956e48a0c5bfb3ac33f6da7e83f341002b6857efd335a505b687be34b75";
    name = "slf4j-parent-1.7.30.pom";
    mavenDir = "org/slf4j/slf4j-parent/1.7.30";
  }
  { url = "https://repo1.maven.org/maven2/org/fxmisc/easybind/easybind/1.0.3/easybind-1.0.3.pom";
    sha256 = "28323c619c05bd0ef05bae81cd056b04f382d7d09ae9e46311e4ec828b611f2a";
    name = "easybind-1.0.3.pom";
    mavenDir = "org/fxmisc/easybind/easybind/1.0.3";
  }
  { url = "https://repo1.maven.org/maven2/org/fxmisc/easybind/easybind/1.0.3/easybind-1.0.3.jar";
    sha256 = "666af296dda6de68751668a62661571b5238ac6f1c07c8a204fc6f902b222aaf";
    name = "easybind-1.0.3.jar";
    mavenDir = "org/fxmisc/easybind/easybind/1.0.3";
  }
  { url = "https://repo1.maven.org/maven2/org/bouncycastle/bcprov-jdk15to18/1.63/bcprov-jdk15to18-1.63.pom";
    sha256 = "40bc5efb0aa8ecb08d180edb4758255648877df6fd44ef0815db960a6c4d828f";
    name = "bcprov-jdk15to18-1.63.pom";
    mavenDir = "org/bouncycastle/bcprov-jdk15to18/1.63";
  }
  { url = "https://repo1.maven.org/maven2/org/bouncycastle/bcprov-jdk15to18/1.63/bcprov-jdk15to18-1.63.jar";
    sha256 = "82c28318b178da751d174b1adf6c43e0199f0fcf80a7bf6483caa226ae0d30b3";
    name = "bcprov-jdk15to18-1.63.jar";
    mavenDir = "org/bouncycastle/bcprov-jdk15to18/1.63";
  }
  { url = "https://repo1.maven.org/maven2/org/bouncycastle/bcpg-jdk15on/1.63/bcpg-jdk15on-1.63.pom";
    sha256 = "4a95f001cbf1a5c333db567ec04f54875e3b12abadc23c69d808b4014559a5d4";
    name = "bcpg-jdk15on-1.63.pom";
    mavenDir = "org/bouncycastle/bcpg-jdk15on/1.63";
  }
  { url = "https://repo1.maven.org/maven2/org/bouncycastle/bcpg-jdk15on/1.63/bcpg-jdk15on-1.63.jar";
    sha256 = "dc4f51adfc46583c2543489c82708fef5660202bf264c7cd453f081a117ea536";
    name = "bcpg-jdk15on-1.63.jar";
    mavenDir = "org/bouncycastle/bcpg-jdk15on/1.63";
  }
  { url = "https://repo1.maven.org/maven2/org/bouncycastle/bcprov-jdk15on/1.63/bcprov-jdk15on-1.63.pom";
    sha256 = "db018a103911a5f3c9762b95483b6b9c875b34d2595b867069ec00567495307c";
    name = "bcprov-jdk15on-1.63.pom";
    mavenDir = "org/bouncycastle/bcprov-jdk15on/1.63";
  }
  { url = "https://repo1.maven.org/maven2/org/bouncycastle/bcprov-jdk15on/1.63/bcprov-jdk15on-1.63.jar";
    sha256 = "28155c8695934f666fabc235f992096e40d97ecb044d5b6b0902db6e15a0b72f";
    name = "bcprov-jdk15on-1.63.jar";
    mavenDir = "org/bouncycastle/bcprov-jdk15on/1.63";
  }
  { url = "https://repo1.maven.org/maven2/org/jetbrains/kotlin/kotlin-stdlib-jdk8/1.3.41/kotlin-stdlib-jdk8-1.3.41.pom";
    sha256 = "e3856758c3bb08b7c97ddcd493521c5e0bd0741717c93b292bf1a541513af082";
    name = "kotlin-stdlib-jdk8-1.3.41.pom";
    mavenDir = "org/jetbrains/kotlin/kotlin-stdlib-jdk8/1.3.41";
  }
  { url = "https://repo1.maven.org/maven2/org/jetbrains/kotlin/kotlin-stdlib-jdk8/1.3.41/kotlin-stdlib-jdk8-1.3.41.jar";
    sha256 = "f7dbbaee3e0841758187a213c052388a4e619e11c87ab16f4bc229cfe7ce5fed";
    name = "kotlin-stdlib-jdk8-1.3.41.jar";
    mavenDir = "org/jetbrains/kotlin/kotlin-stdlib-jdk8/1.3.41";
  }
  { url = "https://repo1.maven.org/maven2/org/jetbrains/kotlin/kotlin-stdlib-jdk7/1.3.41/kotlin-stdlib-jdk7-1.3.41.pom";
    sha256 = "54c3962d2cf839d41bbee8b4817a6b2d06990c305c2efea655f64973d468a5fd";
    name = "kotlin-stdlib-jdk7-1.3.41.pom";
    mavenDir = "org/jetbrains/kotlin/kotlin-stdlib-jdk7/1.3.41";
  }
  { url = "https://repo1.maven.org/maven2/org/jetbrains/kotlin/kotlin-stdlib-jdk7/1.3.41/kotlin-stdlib-jdk7-1.3.41.jar";
    sha256 = "25e2409aba0ec37d2fd7c77727d7835b511879de8d9bf4862af0b493aabbe39e";
    name = "kotlin-stdlib-jdk7-1.3.41.jar";
    mavenDir = "org/jetbrains/kotlin/kotlin-stdlib-jdk7/1.3.41";
  }
  { url = "https://repo1.maven.org/maven2/org/jetbrains/kotlin/kotlin-stdlib/1.3.41/kotlin-stdlib-1.3.41.pom";
    sha256 = "785b5b66f1146317d5ed5b18c8e0c10f83cd5c909434c799a4da9823f028cd63";
    name = "kotlin-stdlib-1.3.41.pom";
    mavenDir = "org/jetbrains/kotlin/kotlin-stdlib/1.3.41";
  }
  { url = "https://repo1.maven.org/maven2/org/jetbrains/kotlin/kotlin-stdlib/1.3.41/kotlin-stdlib-1.3.41.jar";
    sha256 = "6ea3d0921b26919b286f05cbdb906266666a36f9a7c096197114f7495708ffbc";
    name = "kotlin-stdlib-1.3.41.jar";
    mavenDir = "org/jetbrains/kotlin/kotlin-stdlib/1.3.41";
  }
  { url = "https://repo1.maven.org/maven2/org/jetbrains/kotlin/kotlin-stdlib-common/1.3.41/kotlin-stdlib-common-1.3.41.pom";
    sha256 = "d2e537cd1f7705276242d8cc903a0286b6dc86b41b6e728e967ef719022f2e15";
    name = "kotlin-stdlib-common-1.3.41.pom";
    mavenDir = "org/jetbrains/kotlin/kotlin-stdlib-common/1.3.41";
  }
  { url = "https://repo1.maven.org/maven2/org/jetbrains/kotlin/kotlin-stdlib-common/1.3.41/kotlin-stdlib-common-1.3.41.jar";
    sha256 = "6c91dea17d7dce5f0b550c3de3305767e5fb46247b6d1eb7eca0ca1fe18458de";
    name = "kotlin-stdlib-common-1.3.41.jar";
    mavenDir = "org/jetbrains/kotlin/kotlin-stdlib-common/1.3.41";
  }
  { url = "https://repo1.maven.org/maven2/org/jetbrains/annotations/13.0/annotations-13.0.pom";
    sha256 = "965aeb2bedff369819bdde1bf7a0b3b89b8247dd69c88b86375d76163bb8c397";
    name = "annotations-13.0.pom";
    mavenDir = "org/jetbrains/annotations/13.0";
  }
  { url = "https://repo1.maven.org/maven2/org/jetbrains/annotations/13.0/annotations-13.0.jar";
    sha256 = "ace2a10dc8e2d5fd34925ecac03e4988b2c0f851650c94b8cef49ba1bd111478";
    name = "annotations-13.0.jar";
    mavenDir = "org/jetbrains/annotations/13.0";
  }
  { url = "https://repo1.maven.org/maven2/org/tukaani/xz/1.6/xz-1.6.pom";
    sha256 = "06843f984cf0ad3ecd4196861404ddc4af83ec37a1eb7a1773ab89db02b4020f";
    name = "xz-1.6.pom";
    mavenDir = "org/tukaani/xz/1.6";
  }
  { url = "https://repo1.maven.org/maven2/org/tukaani/xz/1.6/xz-1.6.jar";
    sha256 = "a594643d73cc01928cf6ca5ce100e094ea9d73af760a5d4fb6b75fa673ecec96";
    name = "xz-1.6.jar";
    mavenDir = "org/tukaani/xz/1.6";
  }
  { url = "https://repo1.maven.org/maven2/org/projectlombok/lombok/1.18.2/lombok-1.18.2.pom";
    sha256 = "0289d1519dc18762cf1d2a765a768d5f77bfda520ea68e1ee9290b72766a27e4";
    name = "lombok-1.18.2.pom";
    mavenDir = "org/projectlombok/lombok/1.18.2";
  }
  { url = "https://repo1.maven.org/maven2/org/projectlombok/lombok/1.18.2/lombok-1.18.2.jar";
    sha256 = "f13db210efa2092a58bb7befce58ffa502e5fefc5e1099f45007074008756bc0";
    name = "lombok-1.18.2.jar";
    mavenDir = "org/projectlombok/lombok/1.18.2";
  }
  { url = "https://repo1.maven.org/maven2/commons-lang/commons-lang/2.6/commons-lang-2.6.pom";
    sha256 = "ed76b8891c30b566289c743656f8a4d435986982438d40c567c626233247e711";
    name = "commons-lang-2.6.pom";
    mavenDir = "commons-lang/commons-lang/2.6";
  }
  { url = "https://repo1.maven.org/maven2/commons-lang/commons-lang/2.6/commons-lang-2.6.jar";
    sha256 = "50f11b09f877c294d56f24463f47d28f929cf5044f648661c0f0cfbae9a2f49c";
    name = "commons-lang-2.6.jar";
    mavenDir = "commons-lang/commons-lang/2.6";
  }
  { url = "https://repo1.maven.org/maven2/kr/motd/maven/os-maven-plugin/1.6.0/os-maven-plugin-1.6.0.pom";
    sha256 = "cd151f51078a46777b50f8283b882a8ace0c08bbbe17446b3f9ea63c8122fca8";
    name = "os-maven-plugin-1.6.0.pom";
    mavenDir = "kr/motd/maven/os-maven-plugin/1.6.0";
  }
  { url = "https://repo1.maven.org/maven2/kr/motd/maven/os-maven-plugin/1.6.0/os-maven-plugin-1.6.0.jar";
    sha256 = "1cd9d6c089f966711bc7d9564976b3ffe65102616a5247681cc23095cfbdd1ac";
    name = "os-maven-plugin-1.6.0.jar";
    mavenDir = "kr/motd/maven/os-maven-plugin/1.6.0";
  }
  { url = "https://repo1.maven.org/maven2/io/spring/gradle/dependency-management-plugin/1.0.4.RELEASE/dependency-management-plugin-1.0.4.RELEASE.pom";
    sha256 = "e2d07d25af018e0be07a615d32bc889c1c5e19acf912a66433278d321bc166b2";
    name = "dependency-management-plugin-1.0.4.RELEASE.pom";
    mavenDir = "io/spring/gradle/dependency-management-plugin/1.0.4.RELEASE";
  }
  { url = "https://repo1.maven.org/maven2/io/spring/gradle/dependency-management-plugin/1.0.4.RELEASE/dependency-management-plugin-1.0.4.RELEASE.jar";
    sha256 = "37e2b4345ee0b0078d39c24424ab952672d37994ba86135d44c2e76279864f5a";
    name = "dependency-management-plugin-1.0.4.RELEASE.jar";
    mavenDir = "io/spring/gradle/dependency-management-plugin/1.0.4.RELEASE";
  }
  { url = "https://repo1.maven.org/maven2/io/grpc/grpc-stub/1.25.0/grpc-stub-1.25.0.pom";
    sha256 = "8afcbbed84d3d3f64e902ec5ff08b34f670232ed377307692d1dae0699211567";
    name = "grpc-stub-1.25.0.pom";
    mavenDir = "io/grpc/grpc-stub/1.25.0";
  }
  { url = "https://repo1.maven.org/maven2/io/grpc/grpc-stub/1.25.0/grpc-stub-1.25.0.jar";
    sha256 = "1532e291c0e9fd8230a6416c8ebbd902d99c7e2760241ae638ea761aa3dd5f43";
    name = "grpc-stub-1.25.0.jar";
    mavenDir = "io/grpc/grpc-stub/1.25.0";
  }
  { url = "https://repo1.maven.org/maven2/io/grpc/grpc-protobuf/1.25.0/grpc-protobuf-1.25.0.pom";
    sha256 = "76399ced4a9af69b83a2ca0d5df85d0f94b0401c1f9005b84c6987185216e6f8";
    name = "grpc-protobuf-1.25.0.pom";
    mavenDir = "io/grpc/grpc-protobuf/1.25.0";
  }
  { url = "https://repo1.maven.org/maven2/io/grpc/grpc-protobuf/1.25.0/grpc-protobuf-1.25.0.jar";
    sha256 = "454dae7e246dac25526ed5b795d97a5dafedd3cc2042cfc810f02051d7d3e3cb";
    name = "grpc-protobuf-1.25.0.jar";
    mavenDir = "io/grpc/grpc-protobuf/1.25.0";
  }
  { url = "https://repo1.maven.org/maven2/io/grpc/grpc-api/1.25.0/grpc-api-1.25.0.pom";
    sha256 = "8aa2955fdb4a893dacd88a4de00812e841fd5f9b1c184263b7e60aa53d59b568";
    name = "grpc-api-1.25.0.pom";
    mavenDir = "io/grpc/grpc-api/1.25.0";
  }
  { url = "https://repo1.maven.org/maven2/io/grpc/grpc-api/1.25.0/grpc-api-1.25.0.jar";
    sha256 = "a269094009588213ab5386a6fb92426b8056a130b2653d3b4e59e971f2f1ef08";
    name = "grpc-api-1.25.0.jar";
    mavenDir = "io/grpc/grpc-api/1.25.0";
  }
  { url = "https://repo1.maven.org/maven2/io/grpc/grpc-protobuf-lite/1.25.0/grpc-protobuf-lite-1.25.0.pom";
    sha256 = "ff6b3de50e680ba7a40b39981717f485351513d1de3e299866ff94cfaed51573";
    name = "grpc-protobuf-lite-1.25.0.pom";
    mavenDir = "io/grpc/grpc-protobuf-lite/1.25.0";
  }
  { url = "https://repo1.maven.org/maven2/io/grpc/grpc-protobuf-lite/1.25.0/grpc-protobuf-lite-1.25.0.jar";
    sha256 = "9ba9aaa3e6997a04c707793c25e3ec88c6bad86f8d6f6b8b7a1a0c33ea2429d8";
    name = "grpc-protobuf-lite-1.25.0.jar";
    mavenDir = "io/grpc/grpc-protobuf-lite/1.25.0";
  }
  { url = "https://repo1.maven.org/maven2/io/grpc/grpc-netty-shaded/1.25.0/grpc-netty-shaded-1.25.0.pom";
    sha256 = "26a27dd8a7bb5ce04eae4455fd260c914cd6d9d8a2cad1a804c58563ff5fd01f";
    name = "grpc-netty-shaded-1.25.0.pom";
    mavenDir = "io/grpc/grpc-netty-shaded/1.25.0";
  }
  { url = "https://repo1.maven.org/maven2/io/grpc/grpc-netty-shaded/1.25.0/grpc-netty-shaded-1.25.0.jar";
    sha256 = "9edfd45da473d2efbb5683fc3eaf1857e82d2148033d82dd558a7ac38731ea33";
    name = "grpc-netty-shaded-1.25.0.jar";
    mavenDir = "io/grpc/grpc-netty-shaded/1.25.0";
  }
  { url = "https://repo1.maven.org/maven2/io/grpc/grpc-context/1.25.0/grpc-context-1.25.0.pom";
    sha256 = "7658b40a601548133a6ca8c93fa88761aa55f13359d179fc688694844d5702a8";
    name = "grpc-context-1.25.0.pom";
    mavenDir = "io/grpc/grpc-context/1.25.0";
  }
  { url = "https://repo1.maven.org/maven2/io/grpc/grpc-context/1.25.0/grpc-context-1.25.0.jar";
    sha256 = "f4c8f878c320f6fb56c1c14692618f6df8253314b556176e32727afbc5921a73";
    name = "grpc-context-1.25.0.jar";
    mavenDir = "io/grpc/grpc-context/1.25.0";
  }
  { url = "https://repo1.maven.org/maven2/io/grpc/grpc-core/1.25.0/grpc-core-1.25.0.pom";
    sha256 = "84c3213dd54b7f06b8592ac685c75ff03115cec3ed825c5de14658d7ecab69be";
    name = "grpc-core-1.25.0.pom";
    mavenDir = "io/grpc/grpc-core/1.25.0";
  }
  { url = "https://repo1.maven.org/maven2/io/grpc/grpc-core/1.25.0/grpc-core-1.25.0.jar";
    sha256 = "d67fa113fd9cc45a02710f9c41dda9c15191448c14e9e96fcc21839a41345d4c";
    name = "grpc-core-1.25.0.jar";
    mavenDir = "io/grpc/grpc-core/1.25.0";
  }
  { url = "https://repo1.maven.org/maven2/io/github/microutils/kotlin-logging/1.5.4/kotlin-logging-1.5.4.pom";
    sha256 = "4728eddd64e6ae3e1f205a775c6a327b24bd990b86d528584a17450a8b5f00d6";
    name = "kotlin-logging-1.5.4.pom";
    mavenDir = "io/github/microutils/kotlin-logging/1.5.4";
  }
  { url = "https://repo1.maven.org/maven2/io/github/microutils/kotlin-logging/1.5.4/kotlin-logging-1.5.4.jar";
    sha256 = "4992504fd3c6ecdf9ed10874b9508e758bb908af9e9d7af19a61e9afb6b7e27a";
    name = "kotlin-logging-1.5.4.jar";
    mavenDir = "io/github/microutils/kotlin-logging/1.5.4";
  }
  { url = "https://repo1.maven.org/maven2/io/opencensus/opencensus-api/0.21.0/opencensus-api-0.21.0.pom";
    sha256 = "e2f1e8cdb498220315cf0fcdd89f1c0abf3b2bccf9a4ec1f5e59ccbe7848439b";
    name = "opencensus-api-0.21.0.pom";
    mavenDir = "io/opencensus/opencensus-api/0.21.0";
  }
  { url = "https://repo1.maven.org/maven2/io/opencensus/opencensus-api/0.21.0/opencensus-api-0.21.0.jar";
    sha256 = "8e2cb0f6391d8eb0a1bcd01e7748883f0033b1941754f4ed3f19d2c3e4276fc8";
    name = "opencensus-api-0.21.0.jar";
    mavenDir = "io/opencensus/opencensus-api/0.21.0";
  }
  { url = "https://repo1.maven.org/maven2/io/opencensus/opencensus-contrib-grpc-metrics/0.21.0/opencensus-contrib-grpc-metrics-0.21.0.pom";
    sha256 = "908885a1e63cd6ee8c5d281404d41ed3d5bcb1a642e1c0a3ab285d378ef0758e";
    name = "opencensus-contrib-grpc-metrics-0.21.0.pom";
    mavenDir = "io/opencensus/opencensus-contrib-grpc-metrics/0.21.0";
  }
  { url = "https://repo1.maven.org/maven2/io/opencensus/opencensus-contrib-grpc-metrics/0.21.0/opencensus-contrib-grpc-metrics-0.21.0.jar";
    sha256 = "29fc79401082301542cab89d7054d2f0825f184492654c950020553ef4ff0ef8";
    name = "opencensus-contrib-grpc-metrics-0.21.0.jar";
    mavenDir = "io/opencensus/opencensus-contrib-grpc-metrics/0.21.0";
  }
  { url = "https://repo1.maven.org/maven2/io/perfmark/perfmark-api/0.19.0/perfmark-api-0.19.0.pom";
    sha256 = "e73b2e78a5d4a8a6fd50dfb7241586c385165115296297112954bf44e81e646c";
    name = "perfmark-api-0.19.0.pom";
    mavenDir = "io/perfmark/perfmark-api/0.19.0";
  }
  { url = "https://repo1.maven.org/maven2/io/perfmark/perfmark-api/0.19.0/perfmark-api-0.19.0.jar";
    sha256 = "b734ba2149712409a44eabdb799f64768578fee0defe1418bb108fe32ea43e1a";
    name = "perfmark-api-0.19.0.jar";
    mavenDir = "io/perfmark/perfmark-api/0.19.0";
  }
  { url = "https://repo1.maven.org/maven2/commons-logging/commons-logging/1.2/commons-logging-1.2.pom";
    sha256 = "c91ab5aa570d86f6fd07cc158ec6bc2c50080402972ee9179fe24100739fbb20";
    name = "commons-logging-1.2.pom";
    mavenDir = "commons-logging/commons-logging/1.2";
  }
  { url = "https://repo1.maven.org/maven2/commons-logging/commons-logging/1.2/commons-logging-1.2.jar";
    sha256 = "daddea1ea0be0f56978ab3006b8ac92834afeefbd9b7e4e6316fca57df0fa636";
    name = "commons-logging-1.2.jar";
    mavenDir = "commons-logging/commons-logging/1.2";
  }
  { url = "https://repo1.maven.org/maven2/net/glxn/qrgen/1.3/qrgen-1.3.pom";
    sha256 = "ff99b0ecd90de84e2e0a4d8bd3edea59c926005e3354f24ce294390a69112879";
    name = "qrgen-1.3.pom";
    mavenDir = "net/glxn/qrgen/1.3";
  }
  { url = "https://repo1.maven.org/maven2/net/glxn/qrgen/1.3/qrgen-1.3.jar";
    sha256 = "c85d9d8512d91e8ad11fe56259a7825bd50ce0245447e236cf168d1b17591882";
    name = "qrgen-1.3.jar";
    mavenDir = "net/glxn/qrgen/1.3";
  }
  { url = "https://repo1.maven.org/maven2/net/jcip/jcip-annotations/1.0/jcip-annotations-1.0.pom";
    sha256 = "5c19e6848cc550a95664fb082304bc5f9fcf7b672faf03af1635f0e93c268177";
    name = "jcip-annotations-1.0.pom";
    mavenDir = "net/jcip/jcip-annotations/1.0";
  }
  { url = "https://repo1.maven.org/maven2/net/jcip/jcip-annotations/1.0/jcip-annotations-1.0.jar";
    sha256 = "be5805392060c71474bf6c9a67a099471274d30b83eef84bfc4e0889a4f1dcc0";
    name = "jcip-annotations-1.0.jar";
    mavenDir = "net/jcip/jcip-annotations/1.0";
  }
  { url = "https://repo1.maven.org/maven2/net/sf/jopt-simple/jopt-simple/5.0.4/jopt-simple-5.0.4.pom";
    sha256 = "6a67763b76afcd9c80b95e5c5e24782d18cc1b0e3d9b454ad3f8754c76b76815";
    name = "jopt-simple-5.0.4.pom";
    mavenDir = "net/sf/jopt-simple/jopt-simple/5.0.4";
  }
  { url = "https://repo1.maven.org/maven2/net/sf/jopt-simple/jopt-simple/5.0.4/jopt-simple-5.0.4.jar";
    sha256 = "df26cc58f235f477db07f753ba5a3ab243ebe5789d9f89ecf68dd62ea9a66c28";
    name = "jopt-simple-5.0.4.jar";
    mavenDir = "net/sf/jopt-simple/jopt-simple/5.0.4";
  }
  { url = "https://repo1.maven.org/maven2/net/java/jvnet-parent/3/jvnet-parent-3.pom";
    sha256 = "30f5789efa39ddbf96095aada3fc1260c4561faf2f714686717cb2dc5049475a";
    name = "jvnet-parent-3.pom";
    mavenDir = "net/java/jvnet-parent/3";
  }
  { url = "https://repo1.maven.org/maven2/de/jensd/fontawesomefx/8.0.0/fontawesomefx-8.0.0.pom";
    sha256 = "4e4b2f9dc963f8b6437d8e8a9b96fdb82c4e869060b59e5d18acde11aa1dc977";
    name = "fontawesomefx-8.0.0.pom";
    mavenDir = "de/jensd/fontawesomefx/8.0.0";
  }
  { url = "https://repo1.maven.org/maven2/de/jensd/fontawesomefx/8.0.0/fontawesomefx-8.0.0.jar";
    sha256 = "73bacc991a0a6f5cf0f911767c8db161e0949dbca61e8371eb4342e3da96887b";
    name = "fontawesomefx-8.0.0.jar";
    mavenDir = "de/jensd/fontawesomefx/8.0.0";
  }
  { url = "https://repo1.maven.org/maven2/de/jensd/fontawesomefx-materialdesignfont/2.0.26-9.1.2/fontawesomefx-materialdesignfont-2.0.26-9.1.2.pom";
    sha256 = "1bb0abb32c6556c63fdb5ce181a4d38a81e385823915dbd9ebb65116ab99a021";
    name = "fontawesomefx-materialdesignfont-2.0.26-9.1.2.pom";
    mavenDir = "de/jensd/fontawesomefx-materialdesignfont/2.0.26-9.1.2";
  }
  { url = "https://repo1.maven.org/maven2/de/jensd/fontawesomefx-materialdesignfont/2.0.26-9.1.2/fontawesomefx-materialdesignfont-2.0.26-9.1.2.jar";
    sha256 = "dbad8dfdd1c85e298d5bbae25b2399aec9e85064db57b2427d10f3815aa98752";
    name = "fontawesomefx-materialdesignfont-2.0.26-9.1.2.jar";
    mavenDir = "de/jensd/fontawesomefx-materialdesignfont/2.0.26-9.1.2";
  }
  { url = "https://repo1.maven.org/maven2/de/jensd/fontawesomefx-commons/9.1.2/fontawesomefx-commons-9.1.2.pom";
    sha256 = "ab4be6f30afd349b02bda8b6097ed5e229d2b5d3e9568c9cc69e36130c49150c";
    name = "fontawesomefx-commons-9.1.2.pom";
    mavenDir = "de/jensd/fontawesomefx-commons/9.1.2";
  }
  { url = "https://repo1.maven.org/maven2/de/jensd/fontawesomefx-commons/9.1.2/fontawesomefx-commons-9.1.2.jar";
    sha256 = "5539bb3335ecb822dbf928546f57766eeb9f1516cc1417a064b5709629612149";
    name = "fontawesomefx-commons-9.1.2.jar";
    mavenDir = "de/jensd/fontawesomefx-commons/9.1.2";
  }
  { url = "https://repo1.maven.org/maven2/commons-codec/commons-codec/1.13/commons-codec-1.13.pom";
    sha256 = "c2e2a902d38230cf3031d0b434d5de2614fa0ff26d384b6d282aab56c7d3fc69";
    name = "commons-codec-1.13.pom";
    mavenDir = "commons-codec/commons-codec/1.13";
  }
  { url = "https://repo1.maven.org/maven2/commons-codec/commons-codec/1.13/commons-codec-1.13.jar";
    sha256 = "61f7a3079e92b9fdd605238d0295af5fd11ac411a0a0af48deace1f6c5ffa072";
    name = "commons-codec-1.13.jar";
    mavenDir = "commons-codec/commons-codec/1.13";
  }
  { url = "https://repo1.maven.org/maven2/ch/qos/logback/logback-core/1.1.11/logback-core-1.1.11.pom";
    sha256 = "7199197992fb549a4b620f368a6726298360eb9ebb37e4ed16eb4e5ad2be0f25";
    name = "logback-core-1.1.11.pom";
    mavenDir = "ch/qos/logback/logback-core/1.1.11";
  }
  { url = "https://repo1.maven.org/maven2/ch/qos/logback/logback-core/1.1.11/logback-core-1.1.11.jar";
    sha256 = "58738067842476feeae5768e832cd36a0e40ce41576ba5739c3632d376bd8c86";
    name = "logback-core-1.1.11.jar";
    mavenDir = "ch/qos/logback/logback-core/1.1.11";
  }
  { url = "https://repo1.maven.org/maven2/ch/qos/logback/logback-classic/1.1.11/logback-classic-1.1.11.pom";
    sha256 = "936d197f26ed8df79b5e0a8f31772924ef864162dcb5fbc82b15e02dc054b1bd";
    name = "logback-classic-1.1.11.pom";
    mavenDir = "ch/qos/logback/logback-classic/1.1.11";
  }
  { url = "https://repo1.maven.org/maven2/ch/qos/logback/logback-classic/1.1.11/logback-classic-1.1.11.jar";
    sha256 = "86a0268c3c96888d4e49d8a754b5b2173286aee100559e803efcbb0df676c66e";
    name = "logback-classic-1.1.11.jar";
    mavenDir = "ch/qos/logback/logback-classic/1.1.11";
  }
  { url = "https://repo1.maven.org/maven2/ch/qos/logback/logback-parent/1.1.11/logback-parent-1.1.11.pom";
    sha256 = "ec6a3b1ccb21e66c02e36899735c0c2171c5bd3a4ea269a28be95f9f2e8a822b";
    name = "logback-parent-1.1.11.pom";
    mavenDir = "ch/qos/logback/logback-parent/1.1.11";
  }
  { url = "https://repo1.maven.org/maven2/commons-io/commons-io/2.6/commons-io-2.6.pom";
    sha256 = "0c23863893a2291f5a7afdbd8d15923b3948afd87e563fa341cdcf6eae338a60";
    name = "commons-io-2.6.pom";
    mavenDir = "commons-io/commons-io/2.6";
  }
  { url = "https://repo1.maven.org/maven2/commons-io/commons-io/2.6/commons-io-2.6.jar";
    sha256 = "f877d304660ac2a142f3865badfc971dec7ed73c747c7f8d5d2f5139ca736513";
    name = "commons-io-2.6.jar";
    mavenDir = "commons-io/commons-io/2.6";
  }
  { url = "https://repo1.maven.org/maven2/javax/inject/javax.inject/1/javax.inject-1.pom";
    sha256 = "943e12b100627804638fa285805a0ab788a680266531e650921ebfe4621a8bfa";
    name = "javax.inject-1.pom";
    mavenDir = "javax/inject/javax.inject/1";
  }
  { url = "https://repo1.maven.org/maven2/javax/inject/javax.inject/1/javax.inject-1.jar";
    sha256 = "91c77044a50c481636c32d916fd89c9118a72195390452c81065080f957de7ff";
    name = "javax.inject-1.jar";
    mavenDir = "javax/inject/javax.inject/1";
  }
  { url = "https://repo1.maven.org/maven2/javax/annotation/javax.annotation-api/1.2/javax.annotation-api-1.2.pom";
    sha256 = "52d73f35f7e638ce3cb56546f879c20e7f7019f72aa20cde1fa80e97865dfd40";
    name = "javax.annotation-api-1.2.pom";
    mavenDir = "javax/annotation/javax.annotation-api/1.2";
  }
  { url = "https://repo1.maven.org/maven2/javax/annotation/javax.annotation-api/1.2/javax.annotation-api-1.2.jar";
    sha256 = "5909b396ca3a2be10d0eea32c74ef78d816e1b4ead21de1d78de1f890d033e04";
    name = "javax.annotation-api-1.2.jar";
    mavenDir = "javax/annotation/javax.annotation-api/1.2";
  }
  { url = "https://repo1.maven.org/maven2/aopalliance/aopalliance/1.0/aopalliance-1.0.pom";
    sha256 = "26e82330157d6b844b67a8064945e206581e772977183e3e31fec6058aa9a59b";
    name = "aopalliance-1.0.pom";
    mavenDir = "aopalliance/aopalliance/1.0";
  }
  { url = "https://repo1.maven.org/maven2/aopalliance/aopalliance/1.0/aopalliance-1.0.jar";
    sha256 = "0addec670fedcd3f113c5c8091d783280d23f75e3acb841b61a9cdb079376a08";
    name = "aopalliance-1.0.jar";
    mavenDir = "aopalliance/aopalliance/1.0";
  }
  { url = "https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-core/2.11.0/log4j-core-2.11.0.pom";
    sha256 = "101qpygsxndfgxj15mrfqj9sc1gawxs5vizq5hcmgsibaz7rqqnm";
    name = "log4j-core-2.11.0.pom";
    mavenDir = "org/apache/logging/log4j/log4j-core/2.11.0";
  }
  { url = "https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-core/2.11.0/log4j-core-2.11.0.jar";
    sha256 = "1q01h667s35rh24qldmbcbmsf7ikq95hlyd0xhpwzn535nrjj863";
    name = "log4j-core-2.11.0.jar";
    mavenDir = "org/apache/logging/log4j/log4j-core/2.11.0";
  }
  { url = "https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j/2.11.0/log4j-2.11.0.jar";
    sha256 = "1q01h667s35rh24qldmbcbmsf7ikq95hlyd0xhpwzn535nrjj863";
    name = "log4j-2.11.0.jar";
    mavenDir = "org/apache/logging/log4j/log4j/2.11.0";
  }
  { url = "https://repo1.maven.org/maven2/commons-io/commons-io/2.5/commons-io-2.5.pom";
    sha256 = "0c7cpx1i07v15ps6yn0k6h7h14h8ciqnjlkqa2rarmy7ifcv5sr8";
    name = "commons-io-2.5.pom";
    mavenDir = "commons-io/commons-io/2.5";
  }
  { url = "https://repo1.maven.org/maven2/commons-io/commons-io/2.5/commons-io-2.5.jar";
    sha256 = "0x1la4i7s3l8q763csfrw4b8gl5vzj79h7fb1ih6hj93ils1h151";
    name = "commons-io-2.5.jar";
    mavenDir = "commons-io/commons-io/2.5";
  }
  { url = "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus-utils/3.0.24/plexus-utils-3.0.24.pom";
    sha256 = "1rifia2i52qgzsiqibrxkhlcwhnrvmk7mbwdvjy15vgxfmm7y1hi";
    name = "plexus-utils-3.0.24.pom";
    mavenDir = "org/codehaus/plexus/plexus-utils/3.0.24";
  }
  { url = "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus-utils/3.0.24/plexus-utils-3.0.24.jar";
    sha256 = "1d397qlp72rf03nz340rpdgh5s5k688mj2h5sh5gnsnh2a5p9vl3";
    name = "plexus-utils-3.0.24.jar";
    mavenDir = "org/codehaus/plexus/plexus-utils/3.0.24";
  }
  { url = "https://repo1.maven.org/maven2/org/vafer/jdependency/2.1.1/jdependency-2.1.1.jar";
    sha256 = "029s0613pm2kymxdmw0l6788yc6qhcb6g07sv4hhg18pcal26bb4";
    name = "jdependency-2.1.1.jar";
    mavenDir = "org/vafer/jdependency/2.1.1";
  }
  { url = "https://repo1.maven.org/maven2/org/vafer/jdependency/2.1.1/jdependency-2.1.1.pom";
    sha256 = "188rxr1nigd4cbh50p75qjli3aak2akkgn4zpmjkgap0rc3964sa";
    name = "jdependency-2.1.1.pom";
    mavenDir = "org/vafer/jdependency/2.1.1";
  }
  ];
in
  stdenv.mkDerivation {
    name = "bisq-deps";
    dontUnpack = true;

    installPhase = ''
      mkdir $out

      for p in ${toString deps}; do
        ${rsync}/bin/rsync -a $p/ $out/
      done
    '';
  }

