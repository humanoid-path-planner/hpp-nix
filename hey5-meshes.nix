{ fetchFromGitHub, stdenvNoCC }:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "hey5-meshes";
  version = "3.0.4";
  src = fetchFromGitHub {
    owner = "pal-robotics";
    repo = "hey5_description";
    rev = finalAttrs.version;
    hash = "sha256-xcfaeu5Gj/H2dDbkSsVVFwDDYXJzqsOGUAVQfm7ehyg=";
  };
  dontConfigure = true;
  dontBuild = true;
  installPhase = ''
    mkdir -p $out/share/hey5_description
    cp -r meshes $out/share/hey5_description
  '';
})
