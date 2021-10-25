# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{ pkgs ? import <nixpkgs> { } }:

{
  # The `lib`, `modules`, and `overlay` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  example-package = pkgs.callPackage ./pkgs/example-package { };
  # some-qt5-package = pkgs.libsForQt5.callPackage ./pkgs/some-qt5-package { };
  # ...
  century-gothic = pkgs.callPackage ./pkgs/century-gothic { };
  wingdings = pkgs.callPackage ./pkgs/wingdings { };
  trace-font = pkgs.callPackage ./pkgs/data/fonts/trace { };
  battery-icons = pkgs.callPackage ./pkgs/data/fonts/battery-icons { };
  electrum-personal-server = pkgs.callPackage ./pkgs/electrum-personal-server { };
  er-wallpaper = pkgs.haskellPackages.callPackage ./pkgs/er-wallpaper { };
  electrum-hardened = pkgs.callPackage ./pkgs/applications/misc/electrum-hardened { };
  pdf2png = pkgs.callPackage ./pkgs/tools/graphics/pdf2png { };
  rofi-menu = pkgs.callPackage ./pkgs/applications/misc/rofi-menu { };
  electrumx = pkgs.callPackage ./pkgs/applications/blockchains/electrumx { };
  bitcoin-onion-nodes = pkgs.callPackage ./pkgs/applications/blockchains/bitcoin-onion-nodes { };
  nvidia-offload = pkgs.callPackage ./pkgs/os-specific/linux/nvidia-offload { };
  bisq-desktop = pkgs.callPackage ./pkgs/applications/blockchains/bisq-desktop { };
  sparrow = pkgs.callPackage ./pkgs/applications/blockchains/sparrow { };
  muun-recovery-tool = pkgs.callPackage ./pkgs/applications/blockchains/muun-recovery-tool { };
}
