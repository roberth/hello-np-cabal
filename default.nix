{ pkgs ? import <nixpkgs> {} }:
let modifySrc = pkg: src: pkgs.haskell.lib.overrideCabal pkg (drv: {
      inherit src;
      sha256 = null;
      revision = null;
      editedCabalFile = null;
      version = drv.version + "-modified";
      });

    myFilterSource = builtins.filterSource (path: type: !(builtins.any (x: x == baseNameOf path) [".git" "default.nix" "shell.nix" ".nix-project-cache"]));

in modifySrc (pkgs.haskellPackages.callPackage ./hello-np-cabal.nix {}) (myFilterSource ./.)
