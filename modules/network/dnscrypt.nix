{
  ...
}:

{
  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      listen_addresses = [ "127.0.0.1:5300" ];
      # Optional: Customize upstream servers or other settings
      # For example, to use Cloudflare and Quad9:
      server_names = [
        "quad9-dnscrypt"
        "cloudflare"
      ];
    };
  };
}
