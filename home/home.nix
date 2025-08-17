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
    ./config/waybar.nix
    ./config/fish.nix
    ./config/niri/config.nix
    inputs.nvf.homeManagerModules.default
    ./config/fuzzel.nix
    ./config/gammastep.nix
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

    # Emacs
    emacs
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

    gammastep
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

  # niri
#  home.file.".config/niri/config.kdl" = {
#    source = ./config/niri/config.kdl;
#  };

  # emacs
   services.emacs = {
     enable = false;
     package = pkgs.emacs;  # Matches the one in home.packages
     client.enable = true;  # For emacsclient desktop integration
   };

  home.sessionVariables = {
    PATH = "$XDG_CONFIG_HOME/emacs/bin:$PATH";  # Appends to existing PATH
  };

  # Manage your personal Doom config files declaratively
  # Create ~/nixos_config/home/doom/ with init.el, config.el, and packages.el
  home.file.".config/doom" = {
    source = ./config/doom;
    recursive = true;
    force = true;
  };

  # Activation script to install/clone Doom if needed and sync config
  home = {
    activation = {
      installDoomEmacs = lib.hm.dag.entryAfter ["writeBoundary"] ''
        export PATH="${pkgs.git}/bin:${pkgs.ripgrep}/bin:${pkgs.fd}/bin:${pkgs.findutils}/bin:${pkgs.emacs}/bin:$PATH"
        EMACS_DIR="$HOME/.config/emacs"

        if [ ! -d "$EMACS_DIR" ]; then
          ${pkgs.git}/bin/git clone --depth 1 https://github.com/doomemacs/doomemacs "$EMACS_DIR"

          "$EMACS_DIR/bin/doom" install --no-env --no-fonts --force
          "$EMACS_DIR/bin/doom" sync -u
        fi
      '';
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
}
