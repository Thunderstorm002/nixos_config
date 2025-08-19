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
    plugins = [
      inputs.hy3.packages.${pkgs.system}.hy3
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprscrolling
    ];
    settings = {
      monitor = [ ",preferred,auto,auto" ];

      # Variables
      "$terminal" = "ghostty";
      "$fileManager" = "thunar";
      "$menu" = "fuzzel";
      "$Mod" = "SUPER";

      #Autostart
      exec-once = [
        "hyprpaper"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "mako"
        "waybar"
        #"${pkgs.bash}/bin/bash /home/roshan/.config/waybar/launch.sh"
        "hyprctl setcursor catppuccin-mocha-dark-cursors 24"
        #"hyprctl plugin load '$HYPR_PLUGIN_DIR/lib/libhyprexpo.so'"
      ];

      cursor = {
        enable_hyprcursor = true;  # Enable hyprcursor
      };

      env = [
        "HYPRCURSOR_THEME,catppuccin-mocha-dark-cursors"  # Set hyprcursor theme
        "HYPRCURSOR_SIZE,24"  # Cursor size
        "XCURSOR_THEME,catppuccin-mocha-dark-cursors"  # Fallback for XCursor
        "XCURSOR_SIZE,24"  # Fallback size
      ];

      general = {
        gaps_in = 5;
        gaps_out = 0;
        border_size = 0;
        #        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        #        "col.inactive_border" = "rgba(595959aa)";
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

        hyprscrolling = {
          column_width = 1;
          fullscreen_on_one_column = 1;
          focus_fit_method = 1;
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
        follow_mouse = 0;
        sensitivity = 0;
        touchpad = {
          natural_scroll = false;
        };
        #kb_options = "ctrl:nocaps";
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
        "$Mod, F1, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        "$Mod, F2, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        "$Mod, F7, exec, hyprctl hyprsunset gamma -5"
        "$Mod, F8, exec, hyprctl hyprsunset gamma +5"
      ];

      bind = [
        "$Mod, RETURN, exec, $terminal"
        "$Mod, Q, killactive,"
        "$Mod, M, exit,"
        "$Mod SHIFT, T, exec, $fileManager"
        "$Mod, V, togglefloating,"
        "$Mod, D, exec, $menu"
        "$Mod, P, pseudo,"
        "$Mod, J, togglesplit,"
        "$Mod, O, exec, zen"
        "$Mod SHIFT, O, exec, librewolf"
        "$Mod, P, exec, ebook-viewer"
        "$Mod, N, exec, neovide"
        "$Mod, Y, exec, cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"
        "$Mod SHIFT, Y, exec, cliphist wipe"
        "$Mod, F, fullscreen, 0"
        "$Mod, E, exec, emacsclient -nc"
        "$Mod, B, exec, blueman-manager"
        "$Mod, left, hy3:movefocus, l"
        "$Mod, right, hy3:movefocus, r"
        "$Mod, up, hy3:movefocus, u"
        "$Mod, down, hy3:movefocus, d"
        "$Mod, 1, workspace, 1"
        "$Mod, 2, workspace, 2"
        "$Mod, 3, workspace, 3"
        "$Mod, 4, workspace, 4"
        "$Mod, 5, workspace, 5"
        "$Mod, 6, workspace, 6"
        "$Mod, 7, workspace, 7"
        "$Mod, 8, workspace, 8"
        "$Mod, 9, workspace, 9"
        "$Mod, 0, workspace, 10"
        "$Mod SHIFT, 1, movetoworkspace, 1"
        "$Mod SHIFT, 2, movetoworkspace, 2"
        "$Mod SHIFT, 3, movetoworkspace, 3"
        "$Mod SHIFT, 4, movetoworkspace, 4"
        "$Mod SHIFT, 5, movetoworkspace, 5"
        "$Mod SHIFT, 6, movetoworkspace, 6"
        "$Mod SHIFT, 7, movetoworkspace, 7"
        "$Mod SHIFT, 8, movetoworkspace, 8"
        "$Mod SHIFT, 9, movetoworkspace, 9"
        "$Mod SHIFT, 0, movetoworkspace, 10"
        "$Mod, G, togglespecialworkspace, magic"
        "$Mod SHIFT, S, movetoworkspace, special:magic"
        "$Mod, mouse_down, workspace, e+1"
        "$Mod, mouse_up, workspace, e-1"
        "$Mod, Tab, workspace, previous"
        #", Super_L, exec, ${config.xdg.configHome}/waybar/toggle.sh"
        #", Super_L, exec, pkill -SIGUSR1 waybar"
        #"$Mod, Super_L, exec, ${config.xdg.configHome}/waybar/toggle.sh"
        "$Mod SHIFT, W, exec, ${config.xdg.configHome}/waybar/launch.sh"
        #"$Mod, W, exec, ${config.xdg.configHome}/waybar/toggle.sh"
        "$Mod, W, exec, pkill -SIGUSR1 waybar"
        "$Mod, T, hy3:makegroup, tab"
        "$Mod SHIFT, U, hy3:makegroup, h"
        "$Mod, A, hy3:movefocus, l"
        "$Mod, S, hy3:movefocus, r"
        "$Mod SHIFT, A, hy3:movewindow, l, once"
        "$Mod SHIFT, S, hy3:movewindow, r, once"
        "$Mod, Escape, exec, ${config.home.homeDirectory}/nixos_config/bin/fuzzel-power-menu"
        "$Mod, X, exec, ${config.home.homeDirectory}/nixos_config/bin/fuzzel-workspace-apps"

        # bind for hyprscrolling
        # "$Mod, S, layoutmsg, move +col"
        # "$Mod, A, layoutmsg, move -col"
        # "$Mod SHIFT, S, layoutmsg, movewindowto r"
        # "$Mod SHIFT, A, layoutmsg, movewindowto l"
      ];
      bindm = [
        "$Mod, mouse:272, movewindow"
        "$Mod, mouse:273, resizewindow"
      ];
      bindt = [
        ", Super_L, exec, pkill -SIGUSR1 waybar"
      ];
      bindrt = [
        "SUPER, Super_L, exec, pkill -SIGUSR1 waybar"
      ];
      binds = {
        allow_workspace_cycles = true;
      };
      windowrulev2 = [
        "suppressevent maximize, class:.*"
      ];
    };
  };

  # Ensure cursor theme files are in the correct directory
  # home.file.".local/share/icons/catppuccin-mocha-dark-cursors".source = "${pkgs.catppuccin-cursors.mochaDark}/share/icons/catppuccin-mocha-dark-cursors";

}
