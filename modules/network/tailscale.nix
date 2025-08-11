{
  config,
  ...
}:

{
  age.secrets.vpn-preauth = {
    file = ../../secrets/vpn-preauth.age;
    owner = "roshan";
    mode = "440";
  };

  # Tailscale
  services.tailscale = {
    enable = true;
    openFirewall = true;
    authKeyFile = config.age.secrets.vpn-preauth.path;
    extraUpFlags = [
      #"--login-server=https://your-instance" # if you use a non-default tailscale coordinator
      "--accept-routes"
      "--accept-dns=false" # if its' a server you prolly dont need magicdns
    ];
  };
}
