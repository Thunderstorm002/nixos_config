{ config, lib, pkgs, ... }:

{
  programs.niri.settings = {
    input.keyboard.xkb.layout = "us";

    cursor = {
      hide-after-inactive-ms = 5000;
      hide-when-typing = true;
      size = 12;
    };

    outputs."HDMI-A-1" = {
      mode = {
        height = 1080;
        width = 1920;
        refresh = 74.973;
      };
      scale = 1.0;
      variable-refresh-rate = "on-demand";
    };

    xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite-unstable;

    environment = {
      QT_QPA_PLATFORM = "wayland";
      DISPLAY = ":0";
    };

    spawn-at-startup = [
      { command = ["sh" "-c" "wl-paste --type text --watch cliphist store"]; }
      { command = ["sh" "-c" "wl-paste --type image --watch cliphist store"]; }
      { command = ["mako"]; }
      { command = ["waybar"]; }
      { command = ["sh" "-c" "emacs --daemon"]; }
      { command = ["gammastep"]; }
      { command = ["swaybg" "--image" "/home/roshan/nixos_config/modules/desktop/wallpaper/carina_nebula_orig.png"]; }
  ];

    binds = {
      "Mod+D".action.spawn = "fuzzel";
      "Mod+Return" = {
        hotkey-overlay.title = "Open Terminal: ghostty";
        action.spawn = "ghostty";
      };
      "Mod+Q" = {
        repeat = false;
        action.close-window = [];
      };
      "Mod+E".action.spawn = ["sh" "-c" "emacsclient -nc"];
      "Mod+W".action.spawn = "zen";
      "Mod+Shift+T".action.spawn = "thunar";
      "Mod+N".action.spawn = "neovide";
      #"Mod+Y".action.spawn = ["sh" "-c" "cliphist list | fuzzel -dmenu | cliphist decode | wl-copy"];
      "Mod+Y".action.spawn = ["sh" "-c" "WAYLAND_DISPLAY=$WAYLAND_DISPLAY cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"];
      "Mod+Shift+Y".action.spawn = ["sh" "-c" "cliphist wipe"];
      "Mod+B".action.spawn = "blueman-manager";
      "Mod+G".action.spawn = "gammastep";
      "Mod+Escape".action.spawn = ["sh" "-c" "/home/roshan/nixos_config/bin/power_menu"];

    # Keys consist of modifiers separated by + signs, followed by an XKB key name
    # in the end. To find an XKB name for a particular key, you may use a program
    # like wev.
    #
    # "Mod" is a special modifier equal to Super when running on a TTY, and to Alt
    # when running as a winit window.
    #
    # Most actions that you can bind here can also be invoked programmatically with
    # `niri msg action do-something`.

    # Mod-Shift-/, which is usually the same as Mod-?,
    # shows a list of important hotkeys.
    "Mod+Shift+Slash".action.show-hotkey-overlay = [];

    # Suggested binds for running programs: terminal, app launcher, screen locker.
    "Super+Shift+L" = {
      hotkey-overlay.title = "Lock the Screen: swaylock";
      action.spawn =  "swaylock";
    };

    # You can also use a shell. Do this if you need pipes, multiple commands, etc.
    # Note: the entire command goes as a single argument in the end.
    # For example, this is a standard bind to toggle the screen reader (orca).
    # Super+Alt+S hotkey-overlay-title=null { spawn "sh" "-c" "pkill orca || exec orca"; }

    # Example volume keys mappings for PipeWire & WirePlumber.
    # The allow-when-locked=true property makes them work even when the session is locked.
    "Mod+F2" = {
      allow-when-locked = true;
      action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+" ];
    };
    "Mod+F1" = {
      allow-when-locked = true;
      action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-" ];
    };
    "XF86AudioMute" = {
      allow-when-locked = true;
      action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle" ];
    };
    "XF86AudioMicMute" = {
      allow-when-locked = true;
      action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle" ];
    };

    # Example brightness key mappings for brightnessctl.
    "Mod+F3" = {
      allow-when-locked = true;
      action.spawn = [ "brightnessctl" "--class=backlight" "set" "+10%" ];
    };
    "Mod+F4" = {
      allow-when-locked = true;
      action.spawn = [ "brightnessctl" "--class=backlight" "set" "10%-" ];
    };

    # Open/close the Overview: a zoomed-out view of workspaces and windows.
    # You can also move the mouse into the top-left hot corner,
    # or do a four-finger swipe up on a touchpad.
    "Mod+O" = {
      repeat = false;
      action.toggle-overview = [];
    };

    "Mod+Left".action.focus-column-left   = [];
    "Mod+Down".action.focus-window-down   = [];
    "Mod+Up".action.focus-window-up       = [];
    "Mod+Right".action.focus-column-right = [];

    "Mod+A".action.focus-column-left  = [];
    "Mod+J".action.focus-window-down  = [];
    "Mod+K".action.focus-window-up    = [];
    "Mod+S".action.focus-column-right = [];

    "Mod+Ctrl+Left".action.move-column-left   = [];
    "Mod+Ctrl+Down".action.move-window-down   = [];
    "Mod+Ctrl+Up".action.move-window-up       = [];
    "Mod+Ctrl+Right".action.move-column-right = [];

    "Mod+Ctrl+A".action.move-column-left  = [];
    "Mod+Ctrl+J".action.move-window-down  = [];
    "Mod+Ctrl+K".action.move-window-up    = [];
    "Mod+Ctrl+S".action.move-column-right = [];

    # Alternative commands that move across workspaces when reaching
    # the first or last window in a column.
    # Mod+J     { focus-window-or-workspace-down; }
    # Mod+K     { focus-window-or-workspace-up; }
    # Mod+Ctrl+J     { move-window-down-or-to-workspace-down; }
    # Mod+Ctrl+K     { move-window-up-or-to-workspace-up; }

    "Mod+Home".action.focus-column-first        = [];
    "Mod+End".action .focus-column-last         = [];
    "Mod+Ctrl+Home".action.move-column-to-first = [];
    "Mod+Ctrl+End".action.move-column-to-last   = [];

    "Mod+Shift+Left".action.focus-monitor-left  = [];
    "Mod+Shift+Down".action.focus-monitor-down  = [];
    "Mod+Shift+Up".action.focus-monitor-up      = [];
    "Mod+Shift+Right".action.focus-monitor-right = [];
    "Mod+Shift+H".action.focus-monitor-left     = [];
    "Mod+Shift+J".action.focus-monitor-down     = [];
    "Mod+Shift+K".action.focus-monitor-up       = [];
    "Mod+Shift+L".action.focus-monitor-right    = [];

    "Mod+Shift+Ctrl+Left".action.move-column-to-monitor-left  = [];
    "Mod+Shift+Ctrl+Down".action.move-column-to-monitor-down  = [];
    "Mod+Shift+Ctrl+Up".action.move-column-to-monitor-up      = [];
    "Mod+Shift+Ctrl+Right".action.move-column-to-monitor-right = [];
    "Mod+Shift+Ctrl+H".action.move-column-to-monitor-left     = [];
    "Mod+Shift+Ctrl+J".action.move-column-to-monitor-down     = [];
    "Mod+Shift+Ctrl+K".action.move-column-to-monitor-up       = [];
    "Mod+Shift+Ctrl+L".action.move-column-to-monitor-right    = [];

    # Alternatively, there are commands to move just a single window:
    # Mod+Shift+Ctrl+Left  { move-window-to-monitor-left; }
    # ...

    # And you can also move a whole workspace to another monitor:
    # Mod+Shift+Ctrl+Left  { move-workspace-to-monitor-left; }
    # ...

    "Mod+Page_Down".action.focus-workspace-down               = [];
    "Mod+Page_Up".action.focus-workspace-up                   = [];
    "Mod+U".action.focus-workspace-down                       = [];
    "Mod+I".action.focus-workspace-up                         = [];
    "Mod+Ctrl+Page_Down".action.move-column-to-workspace-down = [];
    "Mod+Ctrl+Page_Up".action.move-column-to-workspace-up     = [];
    "Mod+Ctrl+U".action.move-column-to-workspace-down         = [];
    "Mod+Ctrl+I".action.move-column-to-workspace-up           = [];
    # Alternatively, there are commands to move just a single window:
    # Mod+Ctrl+Page_Down { move.ndow-to-workspace-down;  = true}
    #  = tru = true.
    "Mod+Shift+Page_Down".action.move-workspace-down = [];
    "Mod+Shift+Page_Up".action.move-workspace-up     = [];
    "Mod+Shift+U".action.move-workspace-down         = [];
    "Mod+Shift+I".action.move-workspace-up           = [];

    # You can bind mouse wheel scroll ticks using the following syntax.
    # These binds will change direction based on the natural-scroll setting.
    #
    # To avoid scrolling through workspaces really fast, you can use
    # the cooldown-ms property. The bind will be rate-limited to this value.
    # You can set a cooldown on any bind, but it's most useful for the wheel.
    "Mod+WheelScrollDown" = {
      cooldown-ms = 150;
      action.focus-workspace-down = [];
    };
    "Mod+WheelScrollUp" = {
      cooldown-ms = 150;
      action.focus-workspace-up = [];
    };
    "Mod+Ctrl+WheelScrollDown" = {
      cooldown-ms = 150;
      action.move-column-to-workspace-down = [];
    };
    "Mod+Ctrl+WheelScrollUp" = {
      cooldown-ms = 150;
      action.move-column-to-workspace-up = [];
    };

    #Mod+WheelScrollRight      { focus-column-right; }
    #Mod+WheelScrollLeft       { focus-column-left; }
    #Mod+Ctrl+WheelScrollRight { move-column-right; }
    #Mod+Ctrl+WheelScrollLeft  { move-column-left; }

    ## Usually scrolling up and down with Shift in applications results in
    ## horizontal scrolling; these binds replicate that.
    #Mod+Shift+WheelScrollDown      { focus-column-right; }
    #Mod+Shift+WheelScrollUp        { focus-column-left; }
    #Mod+Ctrl+Shift+WheelScrollDown { move-column-right; }
    #Mod+Ctrl+Shift+WheelScrollUp   { move-column-left; }

    # Similarly, you can bind touchpad scroll "ticks".
    # Touchpad scrolling is continuous, so for these binds it is split into
    # discrete intervals.
    # These binds are also affected by touchpad's natural-scroll, so these
    # example binds are "inverted", since we have natural-scroll enabled for
    # touchpads by default.
    # Mod+TouchpadScrollDown { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02+"; }
    # Mod+TouchpadScrollUp   { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02-"; }

    # You can refer to workspaces by index. However, keep in mind that
    # niri is a dynamic workspace system, so these commands are kind of
    # "best effort". Trying to refer to a workspace index bigger than
    # the current workspace count will instead refer to the bottommost
    # (empty) workspace.
    #
    # For example, with 2 workspaces + 1 empty, indices 3, 4, 5 and so on
    # will all refer to the 3rd workspace.
    "Mod+1".action.focus-workspace = 1;
    "Mod+2".action.focus-workspace = 2;
    "Mod+3".action.focus-workspace = 3;
    "Mod+4".action.focus-workspace = 4;
    "Mod+5".action.focus-workspace = 5;
    "Mod+6".action.focus-workspace = 6;
    "Mod+7".action.focus-workspace = 7;
    "Mod+8".action.focus-workspace = 8;
    "Mod+9".action.focus-workspace = 9;
    "Mod+Ctrl+1".action.move-column-to-workspace = 1;
    "Mod+Ctrl+2".action.move-column-to-workspace = 2;
    "Mod+Ctrl+3".action.move-column-to-workspace = 3;
    "Mod+Ctrl+4".action.move-column-to-workspace = 4;
    "Mod+Ctrl+5".action.move-column-to-workspace = 5;
    "Mod+Ctrl+6".action.move-column-to-workspace = 6;
    "Mod+Ctrl+7".action.move-column-to-workspace = 7;
    "Mod+Ctrl+8".action.move-column-to-workspace = 8;
    "Mod+Ctrl+9".action.move-column-to-workspace = 9;

    # Alternatively, there are commands to move just a single window:
    # Mod+Ctrl+1 { move-window-to-workspace 1; }

    # Switches focus between the current and the previous workspace.
    "Mod+Tab".action.focus-workspace-previous = [];

    # The following binds move the focused window in and out of a column.
    # If the window is alone, they will consume it into the nearby column to the side.
    # If the window is already in a column, they will expel it out.
    "Mod+BracketLeft".action.consume-or-expel-window-left   = [];
    "Mod+BracketRight".action.consume-or-expel-window-right = [];

    # Consume one window from the right to the bottom of the focused column.
    "Mod+Comma".action.consume-window-into-column = [];
    # Expel the bottom window from the focused column to the right.
    "Mod+Period".action.expel-window-from-column = [];

    "Mod+R".action.switch-preset-column-width        = [];
    "Mod+F".action.maximize-column                   = [];
    "Mod+Shift+R".action.switch-preset-window-height = [];
    "Mod+Ctrl+R".action.reset-window-height          = [];
    "Mod+Shift+F".action.fullscreen-window           = [];

    # Expand the focused column to space not taken up by other fully visible columns.
    # Makes the column "fill the rest of the space".
    "Mod+Ctrl+F".action.expand-column-to-available-width = [];

    "Mod+C".action.center-column = [];

    # Center all fully visible columns on screen.
    "Mod+Ctrl+C".action.center-visible-columns = [];

    # Finer width adjustments.
    # This command can also:
    # * set width in pixels: "1000"
    # * adjust width in pixels: "-5" or "+5"
    # * set width as a percentage of screen width: "25%"
    # * adjust width as a percentage of screen width: "-10%" or "+10%"
    # Pixel sizes use logical, or scaled, pixels. I.e. on an output with scale 2.0,
    # set-column-width "100" will make the column occupy 200 physical screen pixels.
    "Mod+Minus".action.set-column-width = "-10%";
    "Mod+Equal".action.set-column-width = "+10%";

    # Finer height adjustments when in column with other windows.
    "Mod+Shift+Minus".action.set-window-height = "-10%";
    "Mod+Shift+Equal".action.set-window-height = "+10%";

    # Move the focused window between the floating and the tiling layout.
    "Mod+V".action.toggle-window-floating = [];
    "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = [];

    # Toggle tabbed column display mode.
    # Windows in this column will appear as vertical tabs,
    # rather than stacked on top of each other.
    "Mod+Shift+Ctrl+T".action.toggle-column-tabbed-display = [];

    # Actions to switch layouts.
    # Note: if you uncomment these, make sure you do NOT have
    # a matching layout switch hotkey configured in xkb options above.
    # Having both at once on the same hotkey will break the switching,
    # since it will switch twice upon pressing the hotkey (once by xkb, once by niri).
    # Mod+Space       { switch-layout "next"; }
    # Mod+Shift+Space { switch-layout "prev"; }

    "Print".action.screenshot = [];
    #"Ctrl+Print".action.screenshot-screen = true;
    #"Alt+Print".action.screenshot-window = {write-to-disk = true;};

    # Applications such as remote-desktop clients and software KVM switches may
    # request that niri stops processing the keyboard shortcuts defined here
    # so they may, for example, forward the key presses as-is to a remote machine.
    # It's a good idea to bind an escape hatch to toggle the inhibitor,
    # so a buggy application can't hold your session hostage.
    #
    # The allow-inhibiting=false property can be applied to other binds as well,
    # which ensures niri always processes them, even when an inhibitor is active.
    #"Mod+Escape".action.allow-inhibiting = true;

    # The quit action will show a confirmation dialog to avoid accidental exits.
    "Mod+Ctrl+Alt+Delete".action.quit = [];

    # Powers off the monitors. To turn them back on, do any input like
    # moving the mouse or pressing any other key.
    "Mod+Shift+P".action.power-off-monitors = [];

    };

    layout = {
      default-column-display = "tabbed";
      gaps = 5;
      center-focused-column = "always";
      preset-column-widths = [ {fixed = 1920;} ];
      default-column-width.fixed = 1920;
      focus-ring.enable = false;
      border.enable = false;
    };

    animations = {
      enable = false;
    };

    hotkey-overlay.skip-at-startup = true;

    screenshot-path = "~/Pictures/Screenshots/Screenshot_from_%Y-%m-%d %H-%M-%S.png";

  };
}
