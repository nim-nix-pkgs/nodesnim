{
  description = ''The Nim GUI/2D framework based on OpenGL and SDL2.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-nodesnim-nightly-0_4_2b.flake = false;
  inputs.src-nodesnim-nightly-0_4_2b.owner = "Ethosa";
  inputs.src-nodesnim-nightly-0_4_2b.ref   = "refs/tags/nightly-0.4.2b";
  inputs.src-nodesnim-nightly-0_4_2b.repo  = "nodesnim";
  inputs.src-nodesnim-nightly-0_4_2b.type  = "github";
  
  inputs."compiler".dir   = "nimpkgs/c/compiler";
  inputs."compiler".owner = "riinr";
  inputs."compiler".ref   = "flake-pinning";
  inputs."compiler".repo  = "flake-nimble";
  inputs."compiler".type  = "github";
  inputs."compiler".inputs.nixpkgs.follows = "nixpkgs";
  inputs."compiler".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-nodesnim-nightly-0_4_2b"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-nodesnim-nightly-0_4_2b";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}