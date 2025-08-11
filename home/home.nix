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
    #inputs.kickstart-nixvim.homeManagerModules.default
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
    kitty
    fish

    # GUI Apps
    rofi
    xfce.thunar
    mako # notification client
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
    hyprsunset

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
    noto-fonts-emoji
    nerd-fonts.fira-code
    nerd-fonts._0xproto
    nerd-fonts.noto
    nerd-fonts.droid-sans-mono
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
    syncthing
  ];

  fonts.fontconfig.enable = true;

  services.mako.enable = true;

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

  # Git
  programs.git = {
    enable = true;
    userName = "roshan";
    userEmail = "roshan.nair@protonmail.com";
  };

}
