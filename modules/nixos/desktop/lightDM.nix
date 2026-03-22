{ pkgs, ...}:

{
  services = { 
    xserver = {
      displayManager = {
        lightdm = {
          enable = true;
          greeters = {
            slick = {
              enable = true;
            };
          };
        };
      };
    enable = true;
    };
    displayManager = {
      defaultSession = "hyprland";
    };
  };
  # EOF
}
