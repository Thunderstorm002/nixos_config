{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./niri_config.nix
  ];
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };
}
