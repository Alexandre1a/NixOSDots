{
    boot = {
      loader = {
      	grub = {
	  enable = false;
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
