{
  programs = {
    rsi-launcher = {
      enable = true;

      preCommands = ''
        export MANGO_HUD=1;
      '';
    };
  }; 
}
