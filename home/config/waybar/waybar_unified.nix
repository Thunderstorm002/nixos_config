{ config, lib, pkgs, ... }:

let
  # Shared module configurations (common to both Hyprland and Niri)
  commonModules = {
    clock = {
      timezone = "Asia/Kolkata";
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      format = " {:%H:%M   %d/%m/%Y}";
      format-alt = " {:%A, %B %d, %Y}";
    };

    cpu = {
      format = "󰍛 {usage}%";
      tooltip = true;
      interval = 2;
      states = {
        warning = 70;
        critical = 90;
      };
    };

    memory = {
      format = "󰾆 {percentage}%";
      tooltip-format = "RAM: {used:0.1f}G / {total:0.1f}G\nSwap: {swapUsed:0.1f}G / {swapTotal:0.1f}G";
      states = {
        warning = 70;
        critical = 90;
      };
    };

    temperature = {
      thermal-zone = 2;
      hwmon-path = "/sys/class/hwmon/hwmon0/temp1_input";
      critical-threshold = 80;
      format-critical = "󰸁 {temperatureC}°C";
      format = "󰔏 {temperatureC}°C";
    };

    network = {
      format-wifi = "󰤨 {signalStrength}%";
      format-ethernet = "󰈀 Connected";
      tooltip-format = "{ifname} via {gwaddr}";
      format-linked = "󰈀 {ifname} (No IP)";
      format-disconnected = "󰤭 Disconnected";
      format-alt = "{ifname}: {ipaddr}/{cidr}";
      on-click-right = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
    };

    pulseaudio = {
      format = "{icon} {volume}%";
      format-muted = "󰖁 Muted";
      format-icons = {
        headphone = "󰋋";
        hands-free = "󰋋";
        headset = "󰋋";
        phone = "";
        portable = "";
        car = "";
        default = [ "󰕿" "󰖀" "󰕾" ];
      };
      on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
      on-click-right = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_SINK@ toggle";
    };

    tray = {
      spacing = 10;
      icon-size = 16;
    };

    idle_inhibitor = {
      format = "{icon}";
      format-icons = {
        activated = "󰈈";
        deactivated = "󰈉";
      };
      tooltip-format-activated = "Idle inhibitor: ON";
      tooltip-format-deactivated = "Idle inhibitor: OFF";
    };

    "custom/power" = {
      format = "⏻";
      tooltip = "Power menu";
      on-click = "${pkgs.wlogout}/bin/wlogout";
    };
  };

  # Hyprland-specific settings
  hyprSettings = {
    mainBar = {
      layer = "top";
      position = "bottom";
      mode = "hide";
      start_hidden = true;
      ipc = true;
      height = 42;
      width = 1920;
      spacing = 8;
      margin-top = 8;
      margin-left = 16;
      margin-right = 16;

      modules-left = [
        "hyprland/workspaces"
        "hyprland/window"
      ];

      modules-center = [
        "clock"
      ];

      modules-right = [
        "tray"
        "idle_inhibitor"
        "pulseaudio"
        "network"
        "cpu"
        "memory"
        "temperature"
        "custom/power"
      ];

      "hyprland/workspaces" = {
        disable-scroll = true;
        all-outputs = true;
        warp-on-scroll = false;
        format = "{icon}";
        format-icons = {
          "1" = "󰲠";
          "2" = "󰲢";
          "3" = "󰲤";
          "4" = "󰲦";
          "5" = "󰲨";
          "6" = "󰲪";
          "7" = "󰲬";
          "8" = "󰲮";
          "9" = "󰲰";
          "10" = "󰿬";
        };
      };

      "hyprland/window" = {
        format = "{}";
        max-length = 50;
        separate-outputs = true;
        rewrite = {
          "(.*) — Mozilla Firefox" = " $1";
          "(.*) - Visual Studio Code" = "󰨞 $1";
        };
      };
    } // commonModules;  # Merge common modules
  };

  # Niri-specific settings
  niriSettings = {
    mainBar = {
      layer = "top";
      position = "bottom";
      mode = "hide";
      start_hidden = true;
      ipc = true;
      height = 42;
      width = 1920;
      spacing = 8;
      margin-top = 8;
      margin-left = 16;
      margin-right = 16;

      modules-left = [
        "niri/workspaces"
        "niri/window"
      ];

      modules-center = [
        "clock"
      ];

      modules-right = [
        "tray"
        "idle_inhibitor"
        "pulseaudio"
        "network"
        "cpu"
        "memory"
        "temperature"
        "custom/power"
      ];

      "niri/workspaces" = {
        all-outputs = true;
        format = "{icon}";
        format-icons = {
          "1" = "󰲠";
          "2" = "󰲢";
          "3" = "󰲤";
          "4" = "󰲦";
          "5" = "󰲨";
          "6" = "󰲪";
          "7" = "󰲬";
          "8" = "󰲮";
          "9" = "󰲰";
          "10" = "󰿬";
        };
      };

      "niri/window" = {
        format = "{}";
        separate-outputs = true;
        rewrite = {
          "(.*) — Mozilla Firefox" = " $1";
          "(.*) - Visual Studio Code" = "󰨞 $1";
        };
      };
    } // commonModules;  # Merge common modules
  };

  # Shared style (identical in both original files)
  style = ''
    /* Catppuccin Mocha Color Palette */
    @define-color base   #1e1e2e;
    @define-color mantle #181825;
    @define-color crust  #11111b;

    @define-color text     #cdd6f4;
    @define-color subtext0 #a6adc8;
    @define-color subtext1 #bac2de;

    @define-color surface0 #313244;
    @define-color surface1 #45475a;
    @define-color surface2 #585b70;

    @define-color overlay0 #6c7086;
    @define-color overlay1 #7f849c;
    @define-color overlay2 #9399b2;

    @define-color blue      #2765f6;
    @define-color lavender  #b4befe;
    @define-color sapphire  #74c7ec;
    @define-color sky       #89dceb;
    @define-color teal      #94e2d5;
    @define-color green     #a6e3a1;
    @define-color yellow    #f9e2af;
    @define-color peach     #fab387;
    @define-color maroon    #eba0ac;
    @define-color red       #f38ba8;
    @define-color mauve     #cba6f7;
    @define-color pink      #f5c2e7;
    @define-color flamingo  #f2cdcd;
    @define-color rosewater #f5e0dc;

    * {
      font-family: "JetBrainsMono Nerd Font", monospace;
      font-size: 13px;
      min-height: 0;
      transition: all 0.3s ease;
    }

    window#waybar {
      background: @base;
      color: @text;
      border-radius: 16px;
      border: 2px solid @surface0;
    }

    /* Workspace Styling */
    #workspaces {
      background: @surface0;
      margin: 4px 8px;
      padding: 2px 4px;
      border-radius: 12px;
      border: 1px solid @surface1; /* Optional: Adds a subtle border for definition */
    }

    #workspaces button {
      padding: 4px 8px;
      color: @overlay0;
      background: transparent;
      transition: all 0.3s ease;
    }

    #workspaces button:hover {
      background: @surface1;
      color: @text;
    }

    #workspaces button.active {
      background: @lavender;
      color: @surface0;
      font-weight: bold;
    }

    #workspaces button.urgent {
      background: @red;
      color: @base;
    }

    /* Window Title */
    #window {
      background: @surface0;
      margin: 4px 0;
      padding: 4px 12px;
      border-radius: 12px;
      color: @text;
      font-weight: 500;
    }

    /* Clock */
    #clock {
      background: @surface0;
      color: @sky;
      padding: 4px 16px;
      border-radius: 12px;
      font-weight: bold;
      margin: 4px 0;
    }

    /* System Info Modules */
    #cpu, #memory, #temperature {
      margin: 4px 2px;
      padding: 4px 8px;
      border-radius: 10px;
      font-weight: 500;
    }

    #cpu {
      background: @surface0;
      color: @green;
    }

    #cpu.warning {
      background: @yellow;
      color: @base;
    }

    #cpu.critical {
      background: @red;
      color: @base;
    }

    #memory {
      background: @surface0;
      color: @mauve;
    }

    #memory.warning {
      background: @yellow;
      color: @base;
    }

    #memory.critical {
      background: @red;
      color: @base;
    }

    #temperature {
      background: @surface0;
      color: @sapphire;
    }

    #temperature.critical {
      background: @red;
      color: @base;
    }

    /* Network */
    #network {
      background: @surface0;
      color: @teal;
      padding: 4px 12px;
      border-radius: 12px;
      margin: 4px 2px;
      font-weight: 500;
    }

    #network.disconnected {
      background: @surface0;
      color: @red;
    }

    /* Audio */
    #pulseaudio {
      background: @surface0;
      color: @yellow;
      padding: 4px 12px;
      border-radius: 12px;
      margin: 4px 2px;
      font-weight: 500;
    }

    #pulseaudio.muted {
      color: @red;
    }

    /* Tray */
    #tray {
      background: @surface0;
      margin: 4px 2px;
      padding: 4px 8px;
      border-radius: 12px;
    }

    #tray > .passive {
      -gtk-icon-effect: dim;
    }

    #tray > .needs-attention {
      -gtk-icon-effect: highlight;
      background: @red;
      border-radius: 50%;
    }

    /* Idle Inhibitor */
    #idle_inhibitor {
      background: @surface0;
      color: @lavender;
      padding: 4px 8px;
      border-radius: 12px;
      margin: 4px 2px;
      font-weight: 500;
    }

    #idle_inhibitor.activated {
      background: @green;
      color: @base;
    }

    /* Power Button */
    #custom-power {
      background: @surface0;
      color: @red;
      padding: 4px 12px;
      border-radius: 12px;
      margin: 4px 8px 4px 2px;
      font-weight: bold;
      font-size: 14px;
    }

    #custom-power:hover {
      background: @red;
      color: @base;
      box-shadow: 0 2px 12px alpha(@red, 0.5);
    }

    /* Tooltips */
    tooltip {
      background: @base;
      border: 2px solid @surface0;
      border-radius: 12px;
      color: @text;
      padding: 8px;
    }

    tooltip label {
      color: @text;
    }
  '';
in
{
  # Enable Waybar package (but don't use programs.waybar.settings/style directly)
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
  };

  # Generate Hyprland-specific config file
  home.file.".config/waybar/config-hyprland.json".text = builtins.toJSON hyprSettings;

  # Generate Niri-specific config file
  home.file.".config/waybar/config-niri.json".text = builtins.toJSON niriSettings;

  # Generate shared style file
  #home.file.".config/waybar/style.css".text = style;

    # Generate the launch.sh script that selects config based on WAYBAR_WM
  home.file.".config/waybar/launch.sh" = {
    text = ''
      #!/bin/sh
      # Determine WM from environment variable (fallback to hyprland)
      WM=''${WAYBAR_WM:-hyprland}
      CONFIG=~/.config/waybar/config-''${WM}.json
      STYLE=~/.config/waybar/style.css

      # Quit all running waybar instances
      killall waybar
      pkill waybar
      sleep 0.2

      # Launch Waybar with the selected config and style
      ${pkgs.waybar}/bin/waybar -c $CONFIG -s $STYLE >> ~/.config/waybar/waybar.log 2>&1 &
    '';
    executable = true;
  };
}
