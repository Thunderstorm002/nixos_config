{
  ...
}:

{
  # Configure crab-hole service
  services.crab-hole = {
    enable = true;
    settings = { };
    configFile = "/etc/crab-hole/config.toml"; # Adjust path as needed
  };

  age.secrets.crab-hole-admin-key = {
    file = ../../secrets/crab-hole-admin-key.age;
    owner = "roshan";
    mode = "440";
  };
}
