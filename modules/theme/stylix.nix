{
  pkgs,
  ...
}:

{
  stylix = {
    enable = true;
    polarity = "dark";
    autoEnable = true;
    base16Scheme = "${pkgs.stylix}/share/themes/catppuccin-mocha.yaml";
    cursor = {
      package = pkgs.catppuccin-cursors.mochaDark;
      name = "catppuccin-mocha-dark-cursors";
      size = 24;
    };
    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      monospace = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };

    targets = {
      gtk.enable = true;  # Theme GTK apps
      qt.enable = true;   # Theme Qt apps
    };
  };
}
