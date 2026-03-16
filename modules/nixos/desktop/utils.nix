{pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    kdePackages.gwenview
    kdePackages.ark
    vlc
  ];
}
