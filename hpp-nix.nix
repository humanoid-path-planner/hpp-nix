{
  stdenv,
  hpp-corbaserver,
  hpp-gepetto-viewer,
  hpp-manipulation-corba,
  hpp-task-sequencing,
  lib,
  python3,
  rsync,
}:
python3.pkgs.toPythonModule (stdenv.mkDerivation {
  pname = "hpp-nix";
  version = "0.0.1";

  dontBuild = true;
  dontUnpack = true;

  propagatedBuildInputs = [
    python3.pkgs.numpy
    python3.pkgs.omniorbpy
  ];


  installPhase = ''
    mkdir -p $out/${python3.sitePackages}
    ${lib.getExe rsync} -a ${hpp-corbaserver.out}/${python3.sitePackages}/ $out/${python3.sitePackages}
    ${lib.getExe rsync} -a ${hpp-gepetto-viewer.out}/${python3.sitePackages}/ $out/${python3.sitePackages}
    ${lib.getExe rsync} -a ${hpp-manipulation-corba.out}/${python3.sitePackages}/ $out/${python3.sitePackages}
    ${lib.getExe rsync} -a ${hpp-task-sequencing.out}/${python3.sitePackages}/ $out/${python3.sitePackages}
  '';
})
