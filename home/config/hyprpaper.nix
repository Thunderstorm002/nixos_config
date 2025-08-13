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
      preload = [ "${config.home.homeDirectory}/nixos_config/modules/desktop/wallpaper/carina_nebula_orig.png" ];
      wallpaper = [ ",${config.home.homeDirectory}/nixos_config/modules/desktop/wallpaper/carina_nebula_orig.png" ];
    };
  };
}
