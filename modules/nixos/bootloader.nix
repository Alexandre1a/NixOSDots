{
    boot = {
      loader = {
      	grub = {
	  enable = false;
	  device = "nodev";
	};
        systemd-boot = {
            enable = true;
	    configurationLimit = 2;
        };
        efi = {
            canTouchEfiVariables = true;
        };
      };
    };
}
