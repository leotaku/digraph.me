{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenvNoCC.mkDerivation {
  name = "terraform-shell";
  buildInputs = with pkgs; [ terraform_1_0 packer ];
}
