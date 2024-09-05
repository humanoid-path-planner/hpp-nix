{
  description = "Practicals for Humanoid Path Planner software";

  inputs = {
    nixpkgs.url = "github:gepetto/nixpkgs/hpp";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    gerard-bauzil = {
      url = "github:gepetto/gerard-bauzil/devel";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
    gtsp-laas = {
      url = "git+https://gitlab.laas.fr/gsaurel/gtsp-laas?ref=nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
    hpp-practicals = {
      url = "github:nim65s/hpp-practicals/gtsp";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
    hpp-task-sequencing = {
      url = "github:nim65s/hpp-task-sequencing/nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = inputs.nixpkgs.lib.systems.flakeExposed;
      perSystem =
        {
          pkgs,
          self',
          system,
          ...
        }:
        {
          devShells.default = pkgs.mkShell {
            env = {
                ROS_PACKAGE_PATH = pkgs.lib.concatStringsSep ":" (
                  map (p: "${p}/share") [
                    self'.packages.gerard-bauzil
                    self'.packages.hpp-practicals
                    self'.packages.pmb2-meshes
                    self'.packages.tiago-data
                    self'.packages.tiago-meshes
                    self'.packages.hey5-meshes
                  ]
                );
                LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
                  pkgs.hpp-manipulation
                  pkgs.hpp-manipulation-corba
                ];
              };
            packages = [
              (pkgs.python3.withPackages (_: [
                inputs.gtsp-laas.packages.${system}.gtsp-laas
                self'.packages.default
              ]))
              self'.packages.gepetto-gui
            ];
          };
          packages = {
            inherit (inputs.gerard-bauzil.packages.${system}) gerard-bauzil;
            inherit (inputs.gtsp-laas.packages.${system}) gtsp-laas;
            inherit (inputs.hpp-practicals.packages.${system}) hpp-practicals;
            default = self'.packages.hpp-nix;
            gepetto-gui = with pkgs.python3Packages; toPythonApplication (gepetto-viewer.override {
              plugins = [
                gepetto-viewer-corba
                hpp-gepetto-viewer
                hpp-gui
              ];
            });
            hey5-meshes = pkgs.callPackage ./hey5-meshes.nix { };
            hpp-nix = pkgs.callPackage ./hpp-nix.nix {
              inherit (inputs.hpp-task-sequencing.packages.${system}) hpp-task-sequencing;
            };
            pmb2-meshes = pkgs.callPackage ./pmb2-meshes.nix { };
            tiago-data = pkgs.callPackage ./tiago-data.nix { };
            tiago-meshes = pkgs.callPackage ./tiago-meshes.nix { };
          };
        };
    };
}
