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
}
