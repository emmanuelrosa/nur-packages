# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{ pkgs ? import <nixpkgs> { } }:
let
  system = builtins.currentSystem;
  lock = builtins.fromJSON (builtins.readFile ./flake.lock);
  unpack = archive: strip: pkgs.runCommandLocal "unpack" { inherit archive; } ''mkdir -p $out && ${pkgs.gnutar}/bin/tar -xzf ${archive} --strip-components=${builtins.toString strip} -C $out'';

  flake-compat-tar = pkgs.fetchurl {
    url = "https://github.com/edolstra/flake-compat/archive/${lock.nodes.flake-compat.locked.rev}.tar.gz";
    sha256 = "awLMgZXKXOWRoFLiDTZrwBRpGwclewVq7zloqI1lly0=";
  };

  flake-compat = import (unpack flake-compat-tar 1) { src = ./.; };
in {
  lib = flake-compat.defaultNix.lib;
  modules = flake-compat.defaultNix.nixosModules;
} // flake-compat.defaultNix.packages."${system}"
