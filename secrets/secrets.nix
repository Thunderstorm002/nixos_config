let
  user1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIENpId+0GZrsmsvxFprBcxzqMIQdWKVnzyfQXEhr/tbA roshan.nair.007@gmail.com";
  user2 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGkt+Mg6Q2EZKGfX85VXKRURtO1Ewj4Fu9tO1wdQQoGm roshan@nixos-laptop";
  system1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILibIs4lNQ3v2zmZagX8W2ZnLs6AEqQtTDXS1tqh4s4V root@nixos";
  users = [
    user1
    user2
    system1
  ];
in
{
  #"secret1.age".publickeys = users;
  "secret1.age".publicKeys = [
    user1
    user2
  ];

  "vpn-preauth.age".publicKeys = users;
  "crab-hole-admin-key.age".publicKeys = users;
}
