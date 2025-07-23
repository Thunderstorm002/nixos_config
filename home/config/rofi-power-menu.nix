{
  pkgs,
  config,
}:

{
  my-src = builtins.readFile ../../bin/rofi-power-menu;

  my-script = (pkgs.writeScriptBin "rofi-power-menu" (builtins.readFile ../../bin/rofi-power-menu));
}
