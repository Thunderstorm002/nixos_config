{
  pkgs,
  inputs,
  ...
}:

{
  home.username = "roshan";
  home.homeDirectory = "/home/roshan";
  home.stateVersion = "25.05";

  imports = [
    inputs.kickstart-nixvim.homeManagerModules.default
    ./config/hyprland_config.nix
    ./config/hyprpaper.nix
    ./config/waybar.nix
    ./config/fish.nix
    ./config/podman.nix
    ./config/rofi.nix
  ];

  # User Packages
  home.packages = with pkgs; [
    # Terminal & Shell
    wezterm
    ghostty
    alacritty
    alacritty-theme
    fish

    # GUI Apps
    rofi
    (writeScriptBin "rofi-power-menu" (builtins.readFile ../bin/rofi-power-menu))
    xfce.thunar
    mako # notification client
    upower
    libnotify
    (writeScriptBin "battery-warning" (builtins.readFile ../bin/battery-warning))
    gammastep
    cliphist
    blueman
    inputs.zen-browser.packages.${pkgs.system}.default
    librewolf
    calibre
    neovide
    networkmanagerapplet
    pavucontrol

    # Utilities
    brightnessctl
    grim
    slurp
    mpc-cli # For controlling MPD
    power-profiles-daemon
    rofi-power-menu
    wireplumber
    keepassxc

    #Camera
    droidcam
    android-tools # For USB connection via adb  libinput

    #Browsers
    tor
    tor-browser

    #Communication
    telegram-desktop

    # Fonts
    font-awesome
    roboto
    noto-fonts-color-emoji
    nerd-fonts.fira-code
    nerd-fonts._0xproto
    nerd-fonts.noto
    papirus-icon-theme

    #Rust utilities
    ripgrep
    fd
    zoxide

    #LATEX
    texlive.combined.scheme-full
    texstudio

    adw-gtk3
    adwaita-qt

    # git replacement
    jujutsu
  ];

  fonts.fontconfig.enable = true;

  services.mako.enable = true;

  # GTK settings
  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  # Qt settings
  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

  # Neovim
  programs.nixvim.enable = true;

  # Shell configurations
  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      if [[ -z "$BASH_EXECUTION_STRING" ]] && ! [[ "$(ps --no-header --pid=$PPID --format=comm)" = "fish" ]]; then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish "$LOGIN_OPTION"
      fi
    '';
    shellAliases = {
      ll = "ls -lh";
    };
  };

  # Define systemd service
  systemd.user.services.batterywarning = {
    #description = "Battery Warning Service";
    serviceConfig = {
      ExecStart = "../bin/battery-warning";
      Type = "oneshot"; # Suitable for scripts that run and exit
    };
  };

  # Define systemd timer
  systemd.user.timers.batterywarning = {
    #description = "Run battery warning check every 5 minutes";
    wantedBy = [ "timers.target" ]; # Automatically start on boot
    timerConfig = {
      OnBootSec = "5min"; # Start 5 minutes after boot
      OnUnitActiveSec = "5min"; # Run every 5 minutes after the last run
      Unit = "batterywarning.service";
    };
  };

  # Git
  programs.git = {
    enable = true;
    userName = "roshan";
    userEmail = "roshan.nair@protonmail.com";
  };
}
