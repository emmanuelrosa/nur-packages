# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

let
  system = builtins.currentSystem;
  lock = builtins.fromJSON (builtins.readFile ./flake.lock);
  flake-compat = import (fetchTarball {
    url = "https://github.com/edolstra/flake-compat/archive/${lock.nodes.flake-compat.locked.rev}.tar.gz";
    sha256 = lock.nodes.flake-compat.locked.narHash;
  }) { src = ./.; };
in { pkgs ? import <nixpkgs> { } }: # NOTE: pkgs is ignored
{
  lib = flake-compat.defaultNix.lib;
  modules = flake-compat.defaultNix.nixosModules;
} // flake-compat.defaultNix.packages."${system}"
