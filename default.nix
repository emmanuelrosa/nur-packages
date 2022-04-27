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
  flake-compat = import (pkgs.fetchFromGitHub {
    owner = "edolstra";
    repo = "flake-compat";
    rev = "b4a34015c698c7793d592d66adbab377907a2be8";
    sha256 = "sha256-Z+s0J8/r907g149rllvwhb4pKi8Wam5ij0st8PwAh+E=";
  }) { src = ./.; };
in {
  lib = flake-compat.defaultNix.lib;
  modules = flake-compat.defaultNix.nixosModules;
} // flake-compat.defaultNix.packages."${system}"
