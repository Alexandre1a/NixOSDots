let 
  workspaceBinds = let
    wsList = builtins.genList (i: i + 1) 10;
  in builtins.concatLists (map (ws:
    let keycode = ws + 9;
    in [
      "SUPER, code:${toString keycode}, workspace, ${toString ws}"
      "SUPER SHIFT, code:${toString keycode}, workspace, ${toString ws}"
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
      "$browser"    = "firefox";

      # Input
      input = {
        kb_layout = "fr";
	numlock_by_default = true;
	accel_profile = "flat";
	follow_mouse = "1";
      };

      # Keybinds
      bind = workspaceBinds ++ [
        # Launch binds
        "$mod, Q, killactive"
	"$mod, RETURN, exec, $term"
	"$mod, M, exit"
	"$mod, R, exec, $launcher2"
	"$mod, F, exec, $browser"
	"$mod, E, exec, fileManager"

	# Focus binds
	"$mod, left, movefocus, l"
	"$mod, right, movefocus, r"
	"$mod, up, movefocus, u"
	"$mod, down, movefocus, d"

      ];

    };
  };

}
