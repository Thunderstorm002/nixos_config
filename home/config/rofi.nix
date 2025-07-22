{ config, ... }:
{
  programs.rofi = {
    enable = true;
    theme = "${config.xdg.configHome}/rofi/themes/themes/gruvbox-dark-hard.rasi";
    extraConfig = {
      show-icons = true;
      icon-theme = "Papirus";
    };
  };
}
