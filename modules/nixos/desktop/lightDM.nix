{ pkgs, ...}:

{
  services.xserver = {
      displayManager = {
        defaultSession = "hyprland";
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
  # EOF
}
