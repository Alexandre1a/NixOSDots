{
  # Toute la configuration lié à la langue, etc...
  time.timeZone = "Europe/Paris";
  
  i18n = {
    defaultLocale = "fr_FR.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "fr_FR.UTF-8";
      LC_IDENTIFICATION = "fr_FR.UTF-8";
      LC_MEASURMENT = "fr_FR.UTF-8";
      LC_MONETARY = "fr_FR.UTF-8";
      LC_NAME = "fr_FR.UTF-8";
      LC_NUMERIC = "fr_FR.UTF-8";
      LC_PAPER = "fr_FR.UTF-8";
      LC_TELEPHONE = "fr_FR.UTF-8";
      LC_TIME = "fr_FR.UTF-8";
    };
  };

  # Keymap in X11
  services = {
    xserver = {
      xkb = {
        layout = "fr";
        #variant = "fr";
      };
    };
  };

  # Keymap in the console
  console = {
    keyMap = "fr";
  };
}
