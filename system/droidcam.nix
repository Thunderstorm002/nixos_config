{ config, pkgs, ... }:
let
  v4l2loopback-dc = config.boot.kernelPackages.callPackage (
    pkgs.fetchFromGitHub {
      owner = "aramg";
      repo = "droidcam";
      rev = "v1.6"; # Check for the latest version on GitHub
      sha256 = "1d9qpnmqa3pfwsrpjnxdz76ipk4w37bbxyrazchh4vslnfc886fx";
    }
    + "/linux/v4l2loopback"
  ) { };
  droidcam = pkgs.droidcam;
in
{
  boot.extraModulePackages = [ v4l2loopback-dc ];
  environment.systemPackages = [ droidcam ];
}
