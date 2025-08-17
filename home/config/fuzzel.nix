{ config, lib, pkgs, ... }:

{
    programs.fuzzel = {
        enable = true;
        settings = {
            main = {
                width = 80;
            };
            colors = {
                background = lib.mkForce "0a0e14ff";
                text = lib.mkForce "b3b1adff";
                match = lib.mkForce "26d3b5ff";
                selection = lib.mkForce "ff9940ff";
                selection-text = lib.mkForce "0a0e14ff";
                border = lib.mkForce "59c2ffff";
            };
            border = {
                width = 1;
            };
            dmenu = {
                mode = "text";
            };
        };
    };
  #xdg.configFile."fuzzel/fuzzel.ini".text = ''
  #  #fuzzy=yes
  #  width=80

 ##   [colors]
  #  background=0a0e14ff
  #  text=b3b1adff
  #  match=26d3b5ff
  #  selection=ff9940ff
  #  selection-text=0a0e14ff
  #  border=59c2ffff

 ##   [border]
  #  width=1
  #  # radius=10

 ##   [dmenu]
  #  mode=text  # text|index
  #  exit-immediately-if-empty=no
  #'';
}
