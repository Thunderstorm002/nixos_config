{
  pkgs,
  ...
}:

{
  # Enable Waybar
  programs.waybar = {
    enable = true;
    systemd.enable = false; # Use manual launch via script
    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        height = 10;
        spacing = 4;
        margin-top = 0;
        margin-bottom = 0;
        mode = "hide";
        start_hidden = true;
        ipc = true;
        modules-left = [
          "hyprland/workspaces"
          "hyprland/submap"
        ];
        modules-center = [
          "hyprland/window"
          "clock"
        ];
        modules-right = [
          "mpd"
          "idle_inhibitor"
          "battery"
          "pulseaudio"
          "network"
          "cpu"
          "memory"
          "temperature"
          "custom/power"
        ];
        keyboard-state = {
          numlock = true;
          capslock = true;
          format = "{name} {icon}";
          format-icons = {
            locked = "";
            unlocked = "";
          };
        };
        "hyprland/mode" = {
          format = "<span style=\"italic\">{}</span>";
        };
        "hyprland/scratchpad" = {
          format = "{icon} {count}";
          show-empty = false;
          format-icons = [
            ""
            ""
          ];
          tooltip = true;
          tooltip-format = "{app}: {title}";
        };
        mpd = {
          format = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ";
          format-disconnected = "Disconnected ";
          format-stopped = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
          unknown-tag = "N/A";
          interval = 5;
          consume-icons = {
            on = " ";
          };
          random-icons = {
            off = "<span color=\"#f53c3c\"></span> ";
            on = " ";
          };
          repeat-icons = {
            on = " ";
          };
          single-icons = {
            on = "1 ";
          };
          state-icons = {
            paused = "";
            playing = "";
          };
          tooltip-format = "MPD (connected)";
          tooltip-format-disconnected = "MPD (disconnected)";
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };
        tray = {
          spacing = 10;
        };
        clock = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };
        cpu = {
          format = "{usage}% ";
          tooltip = false;
        };
        memory = {
          format = "{}% ";
        };
        temperature = {
          critical-threshold = 80;
          format = "{temperatureC}°C {icon}";
          format-icons = [
            ""
            ""
            ""
          ];
        };
        backlight = {
          format = "{percent}% {icon}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-full = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-alt = "{time} {icon}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };
        "battery#bat2" = {
          bat = "BAT2";
        };
        power-profiles-daemon = {
          format = "{icon}";
          tooltip-format = "Power profile: {profile}\nDriver: {driver}";
          tooltip = true;
          format-icons = {
            default = "";
            performance = "";
            balanced = "";
            power-saver = "";
          };
        };
        network = {
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ipaddr}/{cidr} ";
          tooltip-format = "{ifname} via {gwaddr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };
        pulseaudio = {
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = "pavucontrol";
        };
        "custom/media" = {
          format = "{icon} {}";
          return-type = "json";
          max-length = 40;
          format-icons = {
            spotify = "";
            default = "🎜";
          };
          escape = true;
          exec = "$HOME/.config/waybar/mediaplayer.py 2> /dev/null";
        };
        "custom/power" = {
          format = "⏻ ";
          tooltip = false;
          menu = "on-click";
          menu-file = "$HOME/.config/waybar/power_menu.xml";
          menu-actions = {
            shutdown = "systemctl poweroff";
            reboot = "systemctl poweroff --reboot";
            suspend = "systemctl suspend";
            hibernate = "systemctl hibernate";
          };
        };
      };
    };
    style = ''
      * {
        font-family: FontAwesome, Roboto, Helvetica, Arial, sans-serif;
        font-size: 13px;
      }
      window#waybar {
        background-color: rgba(43, 48, 59, 0.5);
        border-bottom: 3px solid rgba(100, 114, 125, 0.5);
        color: #ffffff;
        transition-property: background-color;
        transition-duration: .5s;
      }
      window#waybar.hidden {
        opacity: 0.2;
      }
      window#waybar.termite {
        background-color: #3F3F3F;
      }
      window#waybar.chromium {
        background-color: #000000;
        border: none;
      }
      button {
        box-shadow: inset 0 -3px transparent;
        border: none;
        border-radius: 0;
      }
      button:hover {
        background: inherit;
        box-shadow: inset 0 -3px #ffffff;
      }
      #pulseaudio:hover {
        background-color: #a37800;
      }
      #workspaces button {
        padding: 0 5px;
        background-color: transparent;
        color: #ffffff;
      }
      #workspaces button:hover {
        background: rgba(0, 0, 0, 0.2);
      }
      #workspaces button.active {
        background-color: #64727D;
        box-shadow: inset 0 -3px #ffffff;
      }
      #workspaces button.urgent {
        background-color: #eb4d4b;
      }
      #mode {
        background-color: #64727D;
        box-shadow: inset 0 -3px #ffffff;
      }
      #clock,
      #battery,
      #cpu,
      #memory,
      #disk,
      #temperature,
      #backlight,
      #network,
      #pulseaudio,
      #wireplumber,
      #custom-media,
      #tray,
      #mode,
      #idle_inhibitor,
      #scratchpad,
      #power-profiles-daemon,
      #mpd {
        padding: 0 10px;
        color: #ffffff;
      }
      #window,
      #workspaces {
        margin: 0 4px;
      }
      .modules-left > widget:first-child > #workspaces {
        margin-left: 0;
      }
      .modules-right > widget:last-child > #workspaces {
        margin-right: 0;
      }
      #clock {
        background-color: #64727D;
      }
      #battery {
        background-color: #ffffff;
        color: #000000;
      }
      #battery.charging, #battery.plugged {
        color: #ffffff;
        background-color: #26A65B;
      }
      @keyframes blink {
        to {
          background-color: #ffffff;
          color: #000000;
        }
      }
      #battery.critical:not(.charging) {
        background-color: #f53c3c;
        color: #ffffff;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: steps(12);
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }
      #power-profiles-daemon {
        padding-right: 15px;
      }
      #power-profiles-daemon.performance {
        background-color: #f53c3c;
        color: #ffffff;
      }
      #power-profiles-daemon.balanced {
        background-color: #2980b9;
        color: #ffffff;
      }
      #power-profiles-daemon.power-saver {
        background-color: #2ecc71;
        color: #000000;
      }
      label:focus {
        background-color: #000000;
      }
      #cpu {
        background-color: #2ecc71;
        color: #000000;
      }
      #memory {
        background-color: #9b59b6;
      }
      #disk {
        background-color: #964B00;
      }
      #backlight {
        background-color: #90b1b1;
      }
      #network {
        background-color: #2980b9;
      }
      #network.disconnected {
        background-color: #f53c3c;
      }
      #pulseaudio {
        background-color: #f1c40f;
        color: #000000;
      }
      #pulseaudio.muted {
        background-color: #90b1b1;
        color: #2a5c45;
      }
      #wireplumber {
        background-color: #fff0f5;
        color: #000000;
      }
      #wireplumber.muted {
        background-color: #f53c3c;
      }
      #custom-media {
        background-color: #66cc99;
        color: #2a5c45;
        min-width: 100px;
      }
      #custom-media.custom-spotify {
        background-color: #66cc99;
      }
      #custom-media.custom-vlc {
        background-color: #ffa000;
      }
      #temperature {
        background-color: #f0932b;
      }
      #temperature.critical {
        background-color: #eb4d4b;
      }
      #tray {
        background-color: #2980b9;
      }
      #tray > .passive {
        -gtk-icon-effect: dim;
      }
      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        background-color: #eb4d4b;
      }
      #idle_inhibitor {
        background-color: #2d3436;
      }
      #idle_inhibitor.activated {
        background-color: #ecf0f1;
        color: #2d3436;
      }
      #mpd {
        background-color: #66cc99;
        color: #2a5c45;
      }
      #mpd.disconnected {
        background-color: #f53c3c;
      }
      #mpd.stopped {
        background-color: #90b1b1;
      }
      #mpd.paused {
        background-color: #51a37a;
      }
      #language {
        background: #00b093;
        color: #740864;
        padding: 0 5px;
        margin: 0 5px;
        min-width: 16px;
      }
      #keyboard-state {
        background: #97e1ad;
        color: #000000;
        padding: 0 0px;
        margin: 0 5px;
        min-width: 16px;
      }
      #keyboard-state > label {
        padding: 0 5px;
      }
      #keyboard-state > label.locked {
        background: rgba(0, 0, 0, 0.2);
      }
      #scratchpad {
        background: rgba(0, 0, 0, 0.2);
      }
      #scratchpad.empty {
        background-color: transparent;
      }
      #privacy {
        padding: 0;
      }
      #privacy-item {
        padding: 0 5px;
        color: white;
      }
      #privacy-item.screenshare {
        background-color: #cf5700;
      }
      #privacy-item.audio-in {
        background-color: #1ca000;
      }
      #privacy-item.audio-out {
        background-color: #0069d4;
      }
    '';
  };

  # Waybar scripts
  home.file.".config/waybar/launch.sh" = {
    text = ''
      #!/bin/sh
      # Quit all running waybar instances
      killall waybar
      pkill waybar
      sleep 0.2
      # Launch Waybar
      ${pkgs.waybar}/bin/waybar &
    '';
    executable = true;
  };

  home.file.".config/waybar/toggle.sh" = {
    text = ''
      #!/bin/sh
      if [ -f ~/.cache/waybar-disabled ] ;then
        rm ~/.cache/waybar-disabled
      else
        touch ~/.cache/waybar-disabled
      fi
      ~/.config/waybar/launch.sh &
    '';
    executable = true;
  };

  # Placeholder for mediaplayer.py and power_menu.xml
  home.file.".config/waybar/mediaplayer.py".text = ''
    # Placeholder: Add your mediaplayer.py script here
    # See https://github.com/Alexays/Waybar/wiki/Module:-Custom for examples
  '';
  home.file.".config/waybar/power_menu.xml".text = ''
    <menu>
      <item id="shutdown">Shutdown</item>
      <item id="reboot">Reboot</item>
      <item id="suspend">Suspend</item>
      <item id="hibernate">Hibernate</item>
    </menu>
  '';
}
