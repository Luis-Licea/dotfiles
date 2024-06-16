{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  name = "<Program> Development Shell";
  buildInputs = with pkgs; [
    bash
    curl
  ];
}
