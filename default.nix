# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{ pkgs ? import <nixpkgs> { } }:

rec {
  pathToName = pkg: 
    let output = pkgs.runCommandLocal "path-to-package-name" { p = pkg; } ''basename $p | cut -d "-" -f 2- | tr -d "\n" > $out'';
    in builtins.readFile output;

  deprecate = pkg: pkgs.lib.trivial.warn "The NUR emmanuelrosa is deprecated. Please see https://github.com/emmanuelrosa/erosanix to obtain ${pathToName pkg}" pkg;
  goneForGood = pkg: pkgs.lib.trivial.warn "The package ${pathToName pkg} is no longer supported by my NUR." pkg;

  # The `lib`, `modules`, and `overlay` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  example-package = pkgs.callPackage ./pkgs/example-package { };
  # some-qt5-package = pkgs.libsForQt5.callPackage ./pkgs/some-qt5-package { };
  # ...
  century-gothic = deprecate (pkgs.callPackage ./pkgs/century-gothic { });
  wingdings = deprecate (pkgs.callPackage ./pkgs/wingdings { });
  trace-font = deprecate (pkgs.callPackage ./pkgs/data/fonts/trace { });
  battery-icons = deprecate (pkgs.callPackage ./pkgs/data/fonts/battery-icons { });
  electrum-personal-server = deprecate (pkgs.callPackage ./pkgs/electrum-personal-server { });
  er-wallpaper = deprecate (pkgs.haskellPackages.callPackage ./pkgs/er-wallpaper { });
  electrum-hardened = deprecate (pkgs.callPackage ./pkgs/applications/misc/electrum-hardened { });
  pdf2png = deprecate (pkgs.callPackage ./pkgs/tools/graphics/pdf2png { });
  rofi-menu = deprecate (pkgs.callPackage ./pkgs/applications/misc/rofi-menu { });
  electrumx = goneForGood (pkgs.callPackage ./pkgs/applications/blockchains/electrumx { });
  bitcoin-onion-nodes = deprecate (pkgs.callPackage ./pkgs/applications/blockchains/bitcoin-onion-nodes { });
  nvidia-offload = deprecate (deprecate (pkgs.callPackage ./pkgs/os-specific/linux/nvidia-offload { }));
  bisq-desktop = goneForGood (pkgs.callPackage ./pkgs/applications/blockchains/bisq-desktop { });
  sparrow = deprecate (pkgs.callPackage ./pkgs/applications/blockchains/sparrow { });
  muun-recovery-tool = deprecate (pkgs.callPackage ./pkgs/applications/blockchains/muun-recovery-tool { });
  tastyworks = deprecate (pkgs.callPackage ./pkgs/applications/misc/tastyworks { });
  sierrachart = deprecate (pkgs.callPackage ./pkgs/applications/trading/sierrachart { wrapWine = lib.wrapWine;
    wine = pkgs.wineWowPackages.full;
  });
}
