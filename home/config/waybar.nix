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
height = 30; # Increased for a more modern look
spacing = 4;
margin-top = 0;
margin-bottom = 0;
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
"hyprland/submap" = {
format = "<span style="italic">{}";
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
off = "<span color="#f38ba8"> "; # Red for off
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
/* Catppuccin Mocha colors */
@define-color rosewater #f5e0dc;
@define-color flamingo #f2cdcd;
@define-color pink #f5c2e7;
@define-color mauve #cba6f7;
@define-color red #f38ba8;
@define-color maroon #eba0ac;
@define-color peach #fab387;
@define-color yellow #f9e2af;
@define-color green #a6e3a1;
@define-color teal #94e2d5;
@define-color sky #89dceb;
@define-color sapphire #74c7ec;
@define-color blue #89b4fa;
@define-color lavender #b4befe;
@define-color text #cdd6f4;
@define-color subtext1 #bac2de;
@define-color subtext0 #a6adc8;
@define-color overlay2 #9399b2;
@define-color overlay1 #7f849c;
@define-color overlay0 #6c7086;
@define-color surface2 #585b70;
@define-color surface1 #45475a;
@define-color surface0 #313244;
@define-color base #1e1e2e;
@define-color mantle #181825;
@define-color crust #11111b;

{
font-family: FontAwesome, Roboto, Helvetica, Arial, sans-serif;
font-size: 13px;
border: none;
border-radius: 0;
min-height: 0;
}

window#waybar {
background-color: @mantle;
color: @text;
transition-property: background-color;
transition-duration: .5s;
}
window#waybar.hidden {
opacity: 0.2;
}
button {
box-shadow: inset 0 -3px transparent;
border: none;
border-radius: 0;
}
button:hover {
background: inherit;
box-shadow: inset 0 -3px @text;
}
#workspaces button {
padding: 0 5px;
background-color: transparent;
color: @text;
}
#workspaces button:hover {
background: @surface0;
}
#workspaces button.active {
background-color: @surface1;
box-shadow: inset 0 -3px @text;
}
#workspaces button.urgent {
background-color: @red;
}
#submap {
background-color: @surface1;
box-shadow: inset 0 -3px @text;
}
#clock,
#cpu,
#memory,
#temperature,
#network,
#pulseaudio,
#custom-media,
#tray,
#idle_inhibitor,
#mpd {
padding: 0 10px;
color: @text;
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
background-color: @overlay0;
}
#cpu {
background-color: @green;
color: @mantle;
}
#memory {
background-color: @mauve;
}
#temperature {
background-color: @peach;
}
#temperature.critical {
background-color: @red;
}
#network {
background-color: @blue;
}
#network.disconnected {
background-color: @red;
}
#pulseaudio {
background-color: @yellow;
color: @mantle;
}
#pulseaudio.muted {
background-color: @surface1;
color: @overlay0;
}
#custom-media {
background-color: @teal;
color: @mantle;
min-width: 100px;
}
#tray {
background-color: @blue;
}
#tray > .passive {
-gtk-icon-effect: dim;
}
#tray > .needs-attention {
-gtk-icon-effect: highlight;
background-color: @red;
}
#idle_inhibitor {
background-color: @surface2;
}
#idle_inhibitor.activated {
background-color: @overlay2;
color: @mantle;
}
#mpd {
background-color: @green;
color: @mantle;
}
#mpd.disconnected {
background-color: @red;
}
#mpd.stopped {
background-color: @surface1;
}
#mpd.paused {
background-color: @sky;
}
#keyboard-state {
background: @green;
color: @mantle;
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
background: @surface0;
}
#scratchpad.empty {
background-color: transparent;
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
