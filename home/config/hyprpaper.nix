{
  config,
  ...
}:

{
  # Enable Hyprpaper
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      preload = [ "${config.home.homeDirectory}/Pictures/space_1.jpg" ];
      wallpaper = [ ",${config.home.homeDirectory}/Pictures/space_1.jpg" ];
    };
  };
}
