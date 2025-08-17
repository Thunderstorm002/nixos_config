{ config, lib, pkgs, ... }:

{
  xdg.configFile."fuzzel/fuzzel.ini".text = ''
    #fuzzy=yes
    width=80

    [colors]
    background=0a0e14ff
    text=b3b1adff
    match=26d3b5ff
    selection=ff9940ff
    selection-text=0a0e14ff
    border=59c2ffff

    [border]
    width=1
    # radius=10

    [dmenu]
    mode=text  # text|index
    exit-immediately-if-empty=no
  '';
}
