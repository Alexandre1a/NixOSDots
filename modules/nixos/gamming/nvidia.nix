{
  hardware = { 
    #OpenGL
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    #Nvidia Drivers
    nvidia = {     
      open = false; # My 1660S works better with closed source drivers 
      modesetting = {
        enable = true;
      };
    };
  };

  boot = {
    kernelParams = [
      "nvidia-drm.modset=1" # DRM modesetting
    ];
    initrd.kernelModules = [ 
      "nvidia" 
      "nvidia_modeset" 
      "nvidia_uvm" 
      "nvidia_drm" 
    ];
  };

  # Environment variables
  environment.sessionVariables = {
    # Backend GBM for NVIDIA
    GBM_BACKEND = "nvidia-drm";
    
    # Use NVIDIA pilot for libva (video acceleration)
    LIBVA_DRIVER_NAME = "nvidia";
    
    # Vendor library OpenGL
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    
    XDG_SESSION_TYPE = "wayland";
    
    WLR_NO_HARDWARE_CURSORS = "1";
    
    # Native Wayland Electron Apps
    NIXOS_OZONE_WL = "1";
  };

  # Nvidia Drivers
  services.xserver.videoDrivers = ["nvidia"];
}
