{
  hardware = { 
    #OpenGL
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    #Nvidia Drivers
    nvidia = {     
      open = true;
      modesetting = {
        enable = true;
      };
    };
  };

  # Nvidia Drivers
  services.xserver.videoDrivers = ["nvidia"];
}
