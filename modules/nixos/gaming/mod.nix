{ pkgs, ...}:

{
  # Mod managers
  environment.systemPackages = with pkgs; [
    satisfactorymodmanager
  ];
}
