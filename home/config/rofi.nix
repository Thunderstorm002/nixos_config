{ config, ... }:
{
  programs.rofi = {
    enable = true;
    theme = "${config.xdg.configHome}/rofi/themes/themes/Monokai.rasi";
    extraConfig = {
      font = "FiraCode Nerd Font Med 10";
      show-icons = true;
      icon-theme = "Papirus";
    };
  };
}
