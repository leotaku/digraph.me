{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenvNoCC.mkDerivation {
  name = "terraform-shell";
  buildInputs = with pkgs; [ terraform packer ];
}
