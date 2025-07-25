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

  # Disable SDDM
  services.displayManager.sddm.enable = false;
  # Ensure the system boots into a multi-user target (text mode)
  systemd.services.display-manager.enable = false;
}
