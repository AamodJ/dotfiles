{
  nixpkgs ? import <nixpkgs> { },
}:
with nixpkgs;
mkShell {
  packages = with nixpkgs; [
    yamlfmt
    stylua
    shfmt
    luajitPackages.luacheck
    nixfmt
  ];
}
