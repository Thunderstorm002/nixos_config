{ config, lib, pkgs, ... }:

{
  # emacs
  services.emacs = {
   enable = true;
   package = pkgs.emacs-pgtk;  # Matches the one in home.packages
   client.enable = true;  # For emacsclient desktop integration
   client.arguments = "-nc";
   startWithUserSession = "graphical";
   socketActivation.enable = true;
  };

  home.sessionVariables = {
    PATH = "$XDG_CONFIG_HOME/emacs/bin:$PATH";  # Appends to existing PATH
  };

  # Manage your personal Doom config files declaratively
  # Create ~/nixos_config/home/doom/ with init.el, config.el, and packages.el
  home.file.".config/doom" = {
    source = ../doom;
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
}
