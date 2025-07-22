{
  pkgs,
  inputs,
  ...
}:

{
  # Desktop Environment
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  # Display Manager
  #  services.displayManager.sddm = {
  #    enable = true;
  #    wayland.enable = true;
  #  };

  # Disable SDDM
  services.displayManager.sddm.enable = false;
  # Ensure the system boots into a multi-user target (text mode)
  systemd.services.display-manager.enable = false;
}
