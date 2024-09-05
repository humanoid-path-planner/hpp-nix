{ symlinkJoin, python3Packages }:
symlinkJoin {
  name = "hpp-nix";
  paths = with python3Packages; [
    hpp-baxter
    hpp-bezier-com-traj
    hpp-centroidal-dynamics
    hpp-constraints
    hpp-corbaserver
    hpp-environments
    hpp-gepetto-viewer
    hpp-gui
    hpp-manipulation
    hpp-manipulation-corba
    hpp-pinocchio
    hpp-plot
    hpp-practicals
    hpp-romeo
    hpp-task-sequencing.out  # TODO
    hpp-tutorial
    hpp-universal-robot
  ];
}
