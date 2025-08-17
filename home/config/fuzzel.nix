{ config, lib, pkgs, ... }:

{
    programs.fuzzel = {
        enable = true;
        settings = {
            main = {
                width = 60;
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
}
