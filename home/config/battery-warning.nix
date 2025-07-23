{
  pkgs ? import <nixpkgs> { },
}:

pkgs.writeScriptBin {
  name = "battery-warning";
  text = ''
    #!/usr/bin/env bash

    # Get battery status using upower
    BATTERY=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "state|percentage" | awk '{print $2}')
    STATE=$(echo "$BATTERY" | head -n 1)
    PERCENTAGE=$(echo "$BATTERY" | tail -n 1 | sed 's/%//')

    # Define low battery threshold (e.g., 10%)
    THRESHOLD=10

    # Check if battery is discharging and below threshold
    if [[ "$STATE" == "discharging" && "$PERCENTAGE" -le "$THRESHOLD" ]]; then
        notify-send -u critical "Low Battery Warning" "Battery is at ${PERCENTAGE}%! Please connect to a power source."
    fi
  '';
}
