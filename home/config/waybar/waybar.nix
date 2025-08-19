{ config, lib, pkgs, ... }:

let
  # Determine the window manager by checking an environment variable
  # You can set WAYBAR_WM in your session startup scripts
  wm = builtins.getEnv "WAYBAR_WM";
in
{
  # Conditionally import the appropriate Waybar configuration
  imports = if wm == "hyprland" then [
    ./waybar_hypr.nix
  ] else if wm == "niri" then [
    ./waybar_niri.nix
  ] else [
    # Fallback configuration (optional)
    ./waybar_hypr.nix # Default to Hyprland if WM is not set
  ];
}
