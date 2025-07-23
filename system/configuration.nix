{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../modules/desktop/hyprland.nix
    ../modules/system/bluetooth.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot = {
    # Make v4l2loopback kernel module available to NixOS.
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    # Activate kernel module(s).
    kernelModules = [
      # Virtual camera.
      "v4l2loopback"
      # Virtual Microphone. Custom DroidCam v4l2loopback driver needed for audio.
      #    "snd-aloop"
    ];
  };

  fileSystems."/mnt" = {
    device = "/dev/disk/by-uuid/d5ba396c-7117-49eb-82c3-496e174f8984";
    fsType = "btrfs";
    options = [
      "subvol=@ext"
      "compress=zstd"
      "noatime"
      "nofail"
      "uid=1000,gid=100"
    ];
  };

  # Graphics Drivers (Corrected)
  hardware.graphics = {
    enable = true;
  };
  services.xserver.videoDrivers = [ "intel" ]; # Or "nvidia", "amdgpu"

  # Nix Settings
  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Networking
  networking.hostName = "nixos-laptop";
  networking.networkmanager.enable = true;
  services.tailscale.enable = true;

  # Virtualization with Podman
  virtualisation.containers.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  # Time & Language
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  # Sound
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Laptop-specific services
  services.libinput.enable = true;
  services.power-profiles-daemon.enable = true;
  services.logind.extraConfig = ''
    HandleLidSwitch=ignore
    HandleLidSwitchExternalPower=ignore
    HandleLidSwitchDocked=ignore
  '';

  # Fish Shell (Corrected)
  programs.fish.enable = true;

  # User Account
  users.users.roshan = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "podman"
      "networkmanager"
      "video"
    ];
    shell = pkgs.fish;
  };

  # System-wide Packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    neovim
    git
    libgcc
    llvmPackages_20.clang-unwrapped
    curl
    htop
    dive
    podman-tui
    podman-compose
    gnome-themes-extra
    adw-gtk3
    adwaita-qt # Dark Qt theme
    libsForQt5.qt5ct # Qt5 configuration tool
    kdePackages.qt6ct # Qt6 configuration tool
    brightnessctl
    wl-clipboard
    mate.engrampa
    zathura
    papers
    #xbindkeys
    wev
    wtype
    unzip
    nix-prefetch-github
    v4l-utils
    #droidcam # Already included in home.nix, but can be added here for system-wide access
    #android-tools # For USB connection via adb  libinput
  ];

  environment.sessionVariables = {
    # Hint to apps to prefer dark theme
    GTK_THEME = "adw-gtk3-dark";
    QT_STYLE_OVERRIDE = "adwaita-dark";
    # Wayland-specific dark mode hints
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
  };

  # Services
  services.openssh.enable = true;

  # Firewall Configuration
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      22
      80
      443
    ];
  };

  # Enable udisks2 for disk management and auto-mounting
  services.udisks2.enable = true;

  # Enable gvfs for better integration with GTK-based file managers
  # and various virtual filesystems (e.g., trash, sftp, mtp)
  services.gvfs.enable = true;

  system.stateVersion = "25.05";
}
