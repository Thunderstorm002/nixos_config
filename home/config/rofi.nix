{ config, ... }:
{
  programs.rofi = {
    enable = true;
    theme = "${config.xdg.configHome}/rofi/themes/themes/Monokai.rasi";
  };
}
