{
  pkgs,
  inputs,
  ...
}:

{
  home.username = "roshan";
  home.homeDirectory = "/home/roshan";
  home.stateVersion = "25.05";

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

  # User Packages
  home.packages = with pkgs; [
    # Terminal & Shell
    wezterm
    fish

    # GUI Apps
    rofi
    xfce.thunar
    mako
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

    #Rust utilities
    ripgrep
    fd
    zoxide

    #LATEX
    texlive.combined.scheme-full
    texstudio

    adw-gtk3
    adwaita-qt
  ];

  # Neovim
  imports = [
    inputs.kickstart-nixvim.homeManagerModules.default
    ./config/hyprland_config.nix
    ./config/hyprpaper.nix
    ./config/waybar.nix
    ./config/fish.nix
  ];

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

  # Git
  programs.git = {
    enable = true;
    userName = "roshan";
    userEmail = "roshan.nair@protonmail.com";
  };
}
