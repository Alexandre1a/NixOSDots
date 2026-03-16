{pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    okular
  ];
}
