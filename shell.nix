{
  nixpkgs ? import <nixpkgs> { },
}:
with nixpkgs;
mkShell {
  packages = with nixpkgs; [
    yamlfmt
    shellcheck
    typos
    stylua
    shfmt
    luajitPackages.luacheck
    nixfmt
  ];
}
