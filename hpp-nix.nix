{
  stdenv,
  hpp-task-sequencing,
  lib,
  python3Packages,
  rsync,
}:
let
  inherit (python3Packages.python) sitePackages;
in
python3Packages.toPythonModule (stdenv.mkDerivation {
  pname = "hpp-nix";
  version = "0.0.1";

  dontBuild = true;
  dontUnpack = true;

  propagatedBuildInputs = [
    python3Packages.numpy
    python3Packages.omniorbpy
  ];

  installPhase = ''
    mkdir -p $out/${sitePackages}
    for pkg in \
      ${python3Packages.hpp-baxter.out} \
      ${python3Packages.hpp-corbaserver.out} \
      ${python3Packages.hpp-environments.out} \
      ${python3Packages.hpp-gepetto-viewer.out} \
      ${python3Packages.hpp-gui.out} \
      ${python3Packages.hpp-manipulation-corba.out} \
      ${python3Packages.hpp-practicals.out} \
      ${python3Packages.hpp-romeo.out} \
      ${hpp-task-sequencing.out} \
      ${python3Packages.hpp-tutorial.out} \
      ${python3Packages.hpp-universal-robot.out}
    do
        ${lib.getExe rsync} -a $pkg/${sitePackages}/ $out/${sitePackages}
    done
  '';
})
