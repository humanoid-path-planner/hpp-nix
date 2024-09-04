{ fetchFromGitLab, stdenvNoCC }:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "tiago-data";
  version = "1.1.0";
  src = fetchFromGitLab {
    domain = "gitlab.laas.fr";
    owner = "stack-of-tasks";
    repo = "tiago_data";
    rev = "v${finalAttrs.version}";
    hash = "sha256-i9vqWi6OR4HMePBnE3MB6cgmI3hDDmGQ7S9IAgLHQm4=";
  };
  dontConfigure = true;
  dontBuild = true;
  installPhase = ''
    mkdir -p $out/share/tiago_data
    cp -r gazebo meshes robots srdf urdf $out/share/tiago_data/
  '';
})
