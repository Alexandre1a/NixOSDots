{pkgs, ...}:

pkgs.writeShellApplication {
  name = "VolumeManager";
  runtinmeInputs = [
    pkgs.wireplumber
  ];

  text = ''
    case "$1" in
      up)
        wpctl set-volume @DEFAULT_SINK@ 0.05+
	;;
      down)
        wpctl set-volume @DEFAULT_SINK@ 0.05-
	;;
      mute)
        wpctl set-mute @DEFAULT_SINK@ toggle
        ;;
      *)
        echo "Usage: volume {up|down\mute}"
	exit 1
	;;
      esac
    '';
}
