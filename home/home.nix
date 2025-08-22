{
  pkgs,
  inputs,
  lib,
  ...
}:

{
  home.username = "roshan";
  home.homeDirectory = "/home/roshan";
  home.stateVersion = "25.05";

  imports = [
    ./config/hypr/config.nix
    ./config/hypr/hyprpaper.nix
    ./config/hypr/hyprsunset.nix
    ./config/waybar/waybar_hypr.nix
    ./config/fish.nix
    ./config/emacs/emacs.nix
    ./config/niri/config.nix
    inputs.nvf.homeManagerModules.default
    ./config/fuzzel.nix
    ./config/gammastep.nix
    ./config/sioyek/sioyek.nix
    ./config/sioyek/keys.nix
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

    # TUI Apps
    yazi
    lazygit
    gitui

    psmisc
    procps

    # GUI Apps
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
    nerd-fonts.symbols-only
    jetbrains-mono
    papirus-icon-theme
    source-sans-pro
    source-serif-pro
    source-code-pro
    inter

    # theme
    catppuccin-cursors.mochaDark
    hyprcursor

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

    # nix lsp
    alejandra
    #nixfmt
    nil

    # Emacs
    emacsclient-commands
    findutils
    marksman
    shellcheck
    gnumake
    cmake
    aspell
    direnv
    sqlite
    nodejs
    nixfmt
    maim
    rust-analyzer
    shfmt
    pandoc
    graphviz
    imagemagick
    isync
    mu
    clang-tools
    gdtoolkit_4
    libvterm

    hunspell
    hunspellDicts.en_US

    gammastep

    # PDF viewer
    sioyek
  ];

  fonts.fontconfig.enable = true;

  services.mako.enable = true;

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

  # Cursor theme
  # home.pointerCursor = {
  #   gtk.enable = true;  # Apply to GTK apps
  #   x11.enable = true;  # Apply to X11 apps (XWayland)
  #   package = pkgs.catppuccin-cursors.mochaDark;
  #   name = "catppuccin-mocha-dark-cursors";
  #   size = 24;  # Adjust size as needed
  # };

  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.catppuccin-cursors.mochaDark;
      name = "catppuccin-mocha-dark-cursors";
      size = 24;
    };
  };
}
