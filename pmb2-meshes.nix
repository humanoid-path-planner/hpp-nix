{ fetchFromGitHub, stdenvNoCC }:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "pmb2-meshes";
  version = "5.2.0";
  src = fetchFromGitHub {
    owner = "pal-robotics";
    repo = "pmb2_robot";
    rev = finalAttrs.version;
    hash = "sha256-suHbl5eTIHGz5CLCkbyZU8U4NSFG0R7EaLKVBz8+igk=";
  };
  dontConfigure = true;
  dontBuild = true;
  installPhase = ''
    mkdir -p $out/share/pmb2_description
    cp -r pmb2_description/meshes $out/share/pmb2_description
  '';
})
