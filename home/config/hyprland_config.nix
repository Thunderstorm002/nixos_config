{
  pkgs,
  inputs,
  config,
  ...
}:

{
  # Enable Hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    plugins = [ inputs.hy3.packages.${pkgs.system}.hy3 ]; # Add hy3 plugin here
    settings = {
      monitor = [ ",preferred,auto,auto" ];

      # Variables
      "$terminal" = "alacritty";
      "$fileManager" = "thunar";
      "$menu" = "rofi -show drun";
      "$mainMod" = "SUPER";

      #Autostart
      exec-once = [
        "hyprpm reload -n"
        "nm-applet --indicator"
        "hyprpaper"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "mako"
        "gammastep"
        "${pkgs.bash}/bin/bash /home/roshan/.config/waybar/launch.sh"
        #"bluetoothctl connect AC:80:0A:6F:44:47"
      ];

      env = [
        "XCURSOR_SIZE,24"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 0;
        border_size = 0;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        resize_on_border = false;
        allow_tearing = false;
        layout = "hy3";
      };

      decoration = {
        rounding = 10;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = false;
        bezier = [ "myBezier, 0.05, 0.9, 0.1, 1.05" ];
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      plugin = {
        hy3 = {
          tabs = {
            border_width = 1;
            height = 15;
            padding = 0;
            radius = 0;
            col = {
              active = "rgba(33ccff20)";
              "active.border" = "rgba(33ccffee)";
              inactive = "rgba(30303020)";
              "inactive.border" = "rgba(595959aa)";
              urgent = "rgba(ff223340)";
              "urgent.border" = "rgba(ff2233ee)";
            };
          };
          autotile = {
            enable = true;
            trigger_width = 800;
            trigger_height = 500;
          };
        };
      };

      misc = {
        enable_anr_dialog = false;
        force_default_wallpaper = -1;
        disable_hyprland_logo = false;
      };

      cursor = {
        inactive_timeout = 5;
      };

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = false;
        };
        kb_options = "ctrl:nocaps";
      };

      gestures = {
        workspace_swipe = false;
      };

      device = {
        name = "epic-mouse-v1";
        sensitivity = -0.5;
      };

      # Keyboard shortcuts
      # Example volume button that allows press and hold, volume limited to 150%
      binde = [
        "$mainMod, F3, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        "$mainMod, F4, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        "$mainMod, F6, exec, brightnessctl set 5%-"
        "$mainMod, F7, exec, brightnessctl set 5%+"
      ];

      bind = [
        "$mainMod, RETURN, exec, $terminal"
        "$mainMod, Q, killactive,"
        "$mainMod, M, exit,"
        "$mainMod SHIFT, T, exec, $fileManager"
        "$mainMod, V, togglefloating,"
        "$mainMod, D, exec, $menu"
        "$mainMod, P, pseudo,"
        "$mainMod, J, togglesplit,"
        "$mainMod, O, exec, zen"
        "$mainMod SHIFT, O, exec, librewolf"
        "$mainMod, P, exec, ebook-viewer"
        "$mainMod, N, exec, neovide"
        "$mainMod, Y, exec, cliphist list | rofi -dmenu -display-columns 2 | cliphist decode | wl-copy"
        "$mainMod SHIFT, Y, exec, cliphist wipe"
        "$mainMod, F, fullscreen, 0"
        "$mainMod, E, exec, emacsclient -nc"
        "$mainMod, B, exec, blueman-manager"
        "$mainMod, left, hy3:movefocus, l"
        "$mainMod, right, hy3:movefocus, r"
        "$mainMod, up, hy3:movefocus, u"
        "$mainMod, down, hy3:movefocus, d"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
        "$mainMod, Tab, workspace, previous"
        #", Super_L, exec, ${config.xdg.configHome}/waybar/toggle.sh"
        #", Super_L, exec, pkill -SIGUSR1 waybar"
        #"$mainMod, Super_L, exec, ${config.xdg.configHome}/waybar/toggle.sh"
        "$mainMod SHIFT, W, exec, ${config.xdg.configHome}/waybar/launch.sh"
        #"$mainMod, W, exec, ${config.xdg.configHome}/waybar/toggle.sh"
        "$mainMod, W, exec, pkill -SIGUSR1 waybar"
        "$mainMod, T, hy3:makegroup, tab"
        "$mainMod SHIFT, U, hy3:makegroup, h"
        "$mainMod, Z, hy3:movefocus, l"
        "$mainMod, X, hy3:movefocus, r"
        "$mainMod SHIFT, Z, hy3:movewindow, l, once"
        "$mainMod SHIFT, X, hy3:movewindow, r, once"
        "$mainMod SHIFT, N, exec, rofi -show p -modi p:${config.home.homeDirectory}/nixos_config/bin/rofi-power-menu"
      ];
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
      binds = {
        allow_workspace_cycles = true;
      };
      windowrulev2 = [
        "suppressevent maximize, class:.*"
      ];
      group = {
        "col.border_active" = "rgb(909090)";
      };
    };
  };
}
