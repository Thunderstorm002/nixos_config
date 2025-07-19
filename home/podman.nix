{ config, pkgs, ... }:
{
  # Enable Podman for the user
  home.packages = with pkgs; [
    podman
    podman-compose
  ];

  # Configure Podman storage.conf
  xdg.configFile."containers/storage.conf".text = ''
    [storage]
    driver = "overlay"
    runroot = "/mnt/podman/run"
    graphroot = "/mnt/podman/storage"
  '';
}
