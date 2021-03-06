{ nixpkgs ? import <nixpkgs> {}, compiler ? "default" }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, base, bytestring, directory, filepath
      , http-types, stdenv, wai, wai-app-static, wai-extra, warp
      }:
      mkDerivation {
        pname = "haskell-nix-example";
        version = "0.1.0.0";
        src = ./.;
        isLibrary = false;
        isExecutable = true;
        executableHaskellDepends = [
          base bytestring directory filepath http-types wai wai-app-static
          wai-extra warp
        ];
        homepage = "http://lahiru.site/haskell-nix-example";
        description = "Example HTTP API to store and retrieve files, with Nix package manager";
        license = stdenv.lib.licenses.gpl3;
      };

  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};

  drv = haskellPackages.callPackage f {};

in

  if pkgs.lib.inNixShell then drv.env else drv
