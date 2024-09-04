{ fetchFromGitHub, stdenvNoCC }:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "tiago-meshes";
  version = "4.5.0";
  src = fetchFromGitHub {
    owner = "pal-robotics";
    repo = "tiago_robot";
    rev = finalAttrs.version;
    hash = "sha256-sDnApNqJiSkxZxcYB6lGspM0t0KTOHq/MPs+ECLoDX0=";
  };
  dontConfigure = true;
  dontBuild = true;
  installPhase = ''
    mkdir -p $out/share/tiago_description
    cp -r tiago_description/meshes $out/share/tiago_description/
  '';
})
