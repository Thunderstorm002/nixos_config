{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.gammastep = {
    enable = true;

    dawnTime = "6:00";
    duskTime = "18:00";

    provider = "manual";
    latitude = 12.9;
    longitude = 77.6;

    settings = {
      general = {
        adjustment-method = "wayland";

        temp-day = lib.mkForce 5700;
        temp-night = lib.mkForce 4500;

        fade = 1;

        gamma-day = "0.8:0.7:0.8";
        gamma-night = "0.5";
      };
    };
  };
}
