{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./niri_config_mod.nix
  ];
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };
}
