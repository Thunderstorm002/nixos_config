{
  ...
}:

{
  # Configure crab-hole service
  services.crab-hole = {
    enable = true;
    settings = {
      blocklist = {
        include_subdomains = true;
        lists = [
          "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
          "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn/hosts"
          "file:///etc/crab-hole/blocked.txt"
        ];
        allow_list = [ "file:///home/roshan/.config/crab-hole/allowed.txt" ];
      };

      downstream = {
        protocol = "udp";
        listen = "[::]";
        port = 53;
      };

      upstream = {
        nameservers = [
          {
            # dnscrypt-proxy2
            socket_addr = "127.0.0.1:5300";
            protocol = "udp";
            trust_nx_responses = false;
          }

          #          {
          #            socket_addr = "1.1.1.1:853";
          #            protocol = "tls";
          #            tls_dns_name = "1dot1dot1dot1.cloudflare-dns.com";
          #            trust_nx_responses = false;
          #          }
          #          {
          #            socket_addr = "1.0.0.1:853";
          #            protocol = "tls";
          #            tls_dns_name = "1dot1dot1dot1.cloudflare-dns.com";
          #            trust_nx_responses = false;
          #          }
        ];
      }; # upstream
    }; # settings
    #configFile = "/etc/crab-hole/config.toml"; # Adjust path as needed
  };

  #  age.secrets.crab-hole-admin-key = {
  #    file = ../../secrets/crab-hole-admin-key.age;
  #    owner = "roshan";
  #    mode = "440";
  #  };
}
