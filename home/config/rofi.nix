{ config, ... }:
{
  programs.rofi = {
    enable = true;
    theme = "${config.xdg.configHome}/rofi/themes/rofi-themes-collection/themes/squared-nord.rasi";
    extraConfig = {
      modi = "drun,run,window";
      show-icons = true;
      icon-theme = "Papirus";
    };
  };
}
