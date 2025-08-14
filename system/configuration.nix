{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../modules/desktop/hyprland.nix
    ../modules/desktop/sddm.nix
    ./niri/niri.mod.nix
    ../modules/system/bluetooth.nix
    ../modules/network/dnscrypt.nix
    ../modules/network/crab-hole.nix
    ../modules/theme/stylix.nix
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
      "uinput"
      "v4l2loopback"
      # Virtual Microphone. Custom DroidCam v4l2loopback driver needed for audio.
      #    "snd-aloop"
    ];
  };

  # Graphics Drivers (Corrected)
   hardware = {
    graphics = {
      extraPackages = [ pkgs.amdvlk ];
      extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
      enable = true;
      enable32Bit = true;
    };
    amdgpu.amdvlk = {
        enable = true;
        support32Bit.enable = true;
    };
  };
  services.xserver.videoDrivers = ["amdgpu"]; # Or "nvidia", "amdgpu"

  # Nix Settings
  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Networking
  networking.hostName = "homepc";
  networking.networkmanager.enable = true;
  networking.wireless.enable = false;

  age.identityPaths = [
    "/home/roshan/.ssh/id_ed25519" # Adjust to your SSH private key path
    "/ect/ssh/ssh_host_ed_ed25519_key" # if running as root
    # or "/home/roshan/.age/key.txt" if using a dedicated age key
  ];

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

  # Fish Shell (Corrected)
  programs.fish.enable = true;

  # User Account
  users.users.roshan = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];
    shell = pkgs.fish;
  };

  nix.settings.substituters = [
    "https://nix-community.cachix.org"
  ];

  nix.settings.trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  ];

  # System-wide Packages
  environment.systemPackages = with pkgs; [
    libinput
    rustc
    cargo
    usbutils
    jq
    vim
    wget
    git
    ripgrep
    coreutils
    fd
    clang
    libgcc
    curl
    htop
    dive
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

    #vpn
    tailscale

    #DNS
    hickory-dns
    crab-hole
    caddy
    dnscrypt-proxy2

    #Security
    #sops
    #inputs.agenix.packages.x86_64-linux.default
    sudo-rs

    # Audio
    wireplumber

    # Fonts
    fontconfig
    dejavu_fonts

    # Keyboard
    kanata

    # NiriWM
    niri
    fuzzel
    xwayland-satellite
    wayland-utils
    libsecret
    cage
    xdg-desktop-portal-gtk
    swaybg
    swayidle
    swaylock
  ];

  # Disable the traditional sudo module
  security.sudo = {
    enable = false;
    package = pkgs.sudo-rs;
  };

  # Enable sudo-rs
  security.sudo-rs = {
    enable = true;
    wheelNeedsPassword = true; # Require password for wheel group
  };

  # nvf
  programs.nvf = {
    enable = true;
    # your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings = {
      vim.viAlias = false;
      vim.vimAlias = true;
      vim.lsp = {
        enable = true;
      };
    };
  };

  # Services
  services.openssh.enable = true;
  #programs.ssh.startAgent = true;

  # Firewall Configuration
  networking.firewall = {
    enable = true;
    trustedInterfaces = [
      "tailscale0"
      "wlp0s20f3"
    ]; # Allow all traffic from the Tailscale interface
    allowedUDPPorts = [
      config.services.tailscale.port
      53
      8055
    ];
    allowedTCPPorts = [
      22
      80
      443
      853
    ];
  };

  # Enable udisks2 for disk management and auto-mounting
  services.udisks2.enable = true;

  # Enable gvfs for better integration with GTK-based file managers
  # and various virtual filesystems (e.g., trash, sftp, mtp)
  services.gvfs.enable = true;

  # Keyboard
  # Enable the uinput module for Kanata
  hardware.uinput.enable = true;

  # Set up udev rules for uinput permissions
  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';

  # Ensure the uinput group exists
  users.groups.uinput = {};

  # Add the Kanata service user to necessary groups
  systemd.services.kanata-internalKeyboard.serviceConfig = {
    SupplementaryGroups = [
      "input"
      "uinput"
    ];
  };

  # Enable Kanata service
  services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        # Replace with your keyboard device paths
        devices = [
          "/dev/input/by-path/pci-0000:31:00.3-usb-0:4:1.0-event-kbd"
          # Add other device paths if necessary, e.g., for USB keyboards
          # "/dev/input/by-path/pci-0000:00:14.0-usb-0:3:1.0-event-kbd"
        ];
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
         (defsrc
           caps grv         i
                       j    k    l
           lsft rsft
         )
         
         (deflayer default
           @cap @grv        _
                       _    _    _
           _    _
         )
         
         (deflayer arrows
           _    _           up
                       left down rght
           _    _
         )
         
         (defalias
           cap (tap-hold-press 200 200 esc lctl)
           grv (tap-hold-press 200 200 grv (layer-toggle arrows))
         ) 
        '';
      };
    };
  };

  system.stateVersion = "25.05";
}
