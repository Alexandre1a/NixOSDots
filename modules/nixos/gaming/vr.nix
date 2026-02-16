{pkgs, ...}:

{
  environment.systemPackages = with pkgs; [ wivrn ];

  services.avahi = {
    enable = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };

  networking.firewall = {
    allowedTCPPorts = [ 9757 ];
    allowedUDPPorts = [ 9757 ];
  };

# EOF
}
