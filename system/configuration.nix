{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../modules/desktop/hyprland.nix
    ../modules/system/bluetooth.nix
    "${inputs.nix-mineral}/nix-mineral.nix"
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
  networking.wireless.enable = false;

  age.secrets.vpn-preauth = {
    file = "${config.home.homeDirectory}/nixos_config/secrets/vpn-preauth.age";
    owner = "roshan";
    mode = "440";
  };

  #  # Tailscale
  #   services.tailscale = {
  #      enable = true;
  #      openFirewall = true;
  #    authKeyFile = config.age.secrets.vpn-preauth.path;
  #    extraUpFlags = [
  #"--login-server=https://your-instance" # if you use a non-default tailscale coordinator
  #      "--accept-dns=false" # if its' a server you prolly dont need magicdns
  #    ];
  #  };

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
  #services.power-profiles-daemon.enable = true;
  services.logind.extraConfig = ''
    HandleLidSwitch=ignore
    HandleLidSwitchExternalPower=ignore
    HandleLidSwitchDocked=ignore
  '';

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 50;

      #Optional helps save long term battery health (Not Supported by the laptop)
      #START_CHARGE_THRESH_BAT0 = 20; # 20 and below it starts to charge
      #STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging

    };
  };

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

    #battery Warning
    upower
    libnotify
    util-linux

    #Security
    sops
    inputs.agenix.packages.x86_64-linux.default
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

  systemd.services.battery-warning = {
    enable = true;
    description = "Battery warning script";
    wantedBy = [ "graphical-session.target" ]; # Start when graphical session is available
    serviceConfig = {
      ExecStart = "/home/roshan/nixos_config/bin/battery-warning"; # Path to your script
      Type = "oneshot";
    };
  };

  systemd.timers.battery-warning = {
    description = "Run battery warning script every 5 minutes";
    wantedBy = [ "timers.target" ]; # Automatically start on boot
    timerConfig = {
      onBoot = true;
      onUnitActiveSec = "5min";
      unit = "battery-warning.service";
    };
  };

  # Firewall Configuration
  networking.firewall = {
    enable = true;
    trustedInterfaces = [
      "tailscale0"
      "wlp0s20f3"
    ]; # Allow all traffic from the Tailscale interface
    allowedUDPPorts = [ config.services.tailscale.port ];
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
