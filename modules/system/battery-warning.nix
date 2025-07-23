{ pkgs }:

let
  battery-warning = pkgs.writeScriptBin "battery-warning" ''
    #!/usr/bin/env bash

    # Get battery status using upower
    BATTERY=$(${pkgs.upower}/bin/upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "state|percentage" | awk '{print $2}')
    STATE=$(echo "$BATTERY" | head -n 1)
    PERCENTAGE=$(echo "$BATTERY" | tail -n 1 | sed 's/%//')

    # Define low battery threshold
    THRESHOLD=10

    # Check if battery is discharging and below threshold
    if [[ "$STATE" == "discharging" && "$PERCENTAGE" -le "$THRESHOLD" ]]; then
      # Find active session
      ACTIVE_SESSION=$(${pkgs.systemd}/bin/loginctl list-sessions --no-legend | grep -E 'tty|wayland' | awk '{print $1}' | head -n 1)
      if [ -n "$ACTIVE_SESSION" ]; then
        USER=$(${pkgs.systemd}/bin/loginctl show-session "$ACTIVE_SESSION" -p User | cut -d= -f2)
        UID=$(id -u "$USER")
        DBUS_ADDRESS="unix:path=/run/user/$UID/bus"
        # Check if D-Bus session is available
        if [ -S "/run/user/$UID/bus" ]; then
          if sudo -u "$USER" DBUS_SESSION_BUS_ADDRESS="$DBUS_ADDRESS" ${pkgs.libnotify}/bin/notify-send -u critical "Low Battery Warning" "Battery is at $PERCENTAGE%! Please connect to a power source."; then
            logger -t battery-warning "Sent notification to user $USER: Battery at $PERCENTAGE%"
          else
            logger -t battery-warning "Failed to send notification to user $USER: Battery at $PERCENTAGE%"
            echo "Warning: Battery is at $PERCENTAGE%! Please connect to a power source. (Notification failed)" >&2
          fi
        else
          logger -t battery-warning "No D-Bus session found for user $USER: Battery at $PERCENTAGE%"
          echo "Warning: Battery is at $PERCENTAGE%! Please connect to a power source. (No D-Bus session)" >&2
        fi
      else
        logger -t battery-warning "No active session found: Battery at $PERCENTAGE%"
        echo "Warning: Battery is at $PERCENTAGE%! Please connect to a power source. (No active session)" >&2
      fi
    fi
  '';
in
battery-warning
