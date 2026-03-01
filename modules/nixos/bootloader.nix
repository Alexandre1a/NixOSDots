{
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 2;
        extraEntries = {
          "winslop.conf" = ''
            title Winslop 
            efi /EFI/Microsoft/Boot/bootmgfw.efi
          '';
        };  
      };
      efi = {
          canTouchEfiVariables = true;
      };
    };
    kernel = {
      sysctl = {
       "vm.max_map_count" = 16777216;
       "fs.file-max" = 524288;
      };
    };
  }; #End of "boot"
# EOF
}
