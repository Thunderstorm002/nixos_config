{ config, ... }:
{
  programs.rofi = {
    enable = true;
    theme = "${config.xdg.configHome}/rofi/themes/rofi-themes-collection/themes/rounded-blue-dark.rasi";
    extraConfig = {
      modi = "drun,run,window";
      font = "Hack 10";
      show-icons = true;
      icon-theme = "Papirus";
    };
  };
}
