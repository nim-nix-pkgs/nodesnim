{
  description = ''The Nim GUI/2D framework based on OpenGL and SDL2.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-nodesnim-nightly-0_4_0b.flake = false;
  inputs.src-nodesnim-nightly-0_4_0b.ref   = "refs/tags/nightly-0.4.0b";
  inputs.src-nodesnim-nightly-0_4_0b.owner = "Ethosa";
  inputs.src-nodesnim-nightly-0_4_0b.repo  = "nodesnim";
  inputs.src-nodesnim-nightly-0_4_0b.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-nodesnim-nightly-0_4_0b"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-nodesnim-nightly-0_4_0b";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}