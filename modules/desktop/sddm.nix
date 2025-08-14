{ config, lib, pkgs, ... }:

{
  #services.xserver.enable = true;
  services.displayManager.sessionPackages = with pkgs; [
    hyprland
    niri
  ];
  # Ensure SDDM is configured to handle Wayland sessions
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true; # Explicitly enable Wayland support for SDDM
  };
  # Ensure the system boots into a multi-user target (text mode)
  #systemd.services.display-manager.enable = true;
}
