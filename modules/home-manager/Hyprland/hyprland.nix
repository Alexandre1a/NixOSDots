{ pkgs, ... }:

let
  workspaceBinds = let
    wsList = builtins.genList (i: i + 1) 10;
  in builtins.concatLists (map (ws:
    let keycode = ws + 9;
    in [
      "$mod, code:${toString keycode}, workspace, ${toString ws}"
      "$mod SHIFT, code:${toString keycode}, movetoworkspace, ${toString ws}"
    ]
  ) wsList);
in
{
  wayland.windowManager.hyprland =
  {
    enable = true;

    # Config
    settings =
    {
      # Variables
      "$mod"        = "SUPER";
      "$term"       = "alacritty";
      "$launcher"   = "wofi --show drun";
      "$launcher2"  = "hyprlauncher";
      "fileManager" = "dolphin";
      "$browser"    = "zen";
      "$screenShot" = "hyprshot -m region";
      # Todo : Add a notification daemon

      exec-once = [
        "hyprlauncher"
      ];

      # Input
      input = {
        kb_layout = "fr";
	  numlock_by_default = true;
	  accel_profile = "flat";
	  follow_mouse = "1";
      };

      # Monitor config
      monitor = [
        "HDMI-A-1, 1920x1080@144, 1440x0, 1"
	"DP-1, 1440x900@59.89, 0x0, 1"
        ", highres, auto, 1"
      ];

      # Assign workspaces to monitors
      workspace = [
        "1, default:true, persistent:true"
        "2, monitor:HDMI-A-1"
	"3, monitor:HDMI-A-1"
      	"4, monitor:HDMI-A-1"
	"5, monitor:HDMI-A-1"
      	"6, monitor:DP-1"
      	"7, monitor:DP-1"
	"8, monitor:DP-1"
      	"9, monitor:DP-1"
      	"10, monitor:DP-1"

      ];

      # Keybinds
      bind = workspaceBinds ++ [
        # Launch binds
        "$mod, Q, killactive"
	"$mod, RETURN, exec, $term"
	"$mod, M, exit"
	"$mod, R, exec, $launcher2"
	"$mod SHIFT, F, exec, $browser"
        "$mod, E, exec, $fileManager"
        "$mod, F, fullscreen"
        "$mod, PRINT, exec, $screenShot"


        # Focus binds
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        # Scroll through workspaces with mouse scroll
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
      ];

      # Mouse binds
      bindm = [
        "$mod, mouse:272, movewindow"
	"$mod, mouse: 273, resizewindow"
      ];

      bindl = [
        ", XF86AudioPause, exec, playerctl play-pause"
	", XF86AudioPlay, exec, playerctl play-pause"
	", XF86AudioRaiseVolume, exec, VolumeManager up"
	", XF86AudioLowerVolume, exec, VolumeManager down"
	", XF86AudioMute, exec, VolumeManager mute"
      ];

      # Layout config
      general = {
        layout = "dwindle";
      };

      dwindle = {
        force_split = 0;
	preserve_split = true;
      };

    };
  }; 

  home.packages = with pkgs; [
    # Custom scripts
    (import ./scripts.nix { inherit pkgs; })
    # Hyprland related (rice, etc...)
    wofi
    alacritty
    firefox
    cava
    # File manager
    kdePackages.dolphin
    kdePackages.gwenview
    # Hypr* ecosystem
    hyprlauncher
    hyprshot
    hyprpolkitagent
  ];
}
