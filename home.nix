{lib, ...}: {
  imports = let
    filter = f: lib.hasSuffix ".nix" f;
    getNix = dir: builtins.filter filter (builtins.attrNames (builtins.readDir dir));
    ls = dir: builtins.map (f: (dir + "/${f}")) (getNix dir);
  in
    []
    ++ (ls ./home);
}
