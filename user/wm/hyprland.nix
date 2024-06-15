{inputs, pkgs, ...}: 
{
 wayland.windowManager.hyprland = {
    enable = true;
	extraConfig = ''
		misc {
		  force_default_wallpaper = 0
		}
		decoration {
		}
	'';
settings = {
    "$mod" = "SUPER";
	exec-once = [
		"ags"
		"swww-daemon"
	];
	bindm = [
		"$mod, mouse:272, movewindow"
		"$mod, mouse:273, resizewindow"
	];
    bind =
      [
        "$mod, RETURN, exec, wezterm"
		"$mod, D, exec, wofi --show run"
		",Print,exec,grim"

		"$mod, F, fullscreen"
		"$mod, Q, killactive"

		# Brightness and volume keys
		",XF86AudioRaiseVolume,exec,pamixer -i 3"
		",XF86AudioLowerVolume,exec,pamixer -d 3"
		",XF86AudioMute,exec,pamixer -t"
		",XF86MonBrightnessUp,exec,brightnessctl s 3%+"
		",XF86MonBrightnessUp,exec,brightnessctl s 3%-"

		"$mod, V, togglefloating"

		"$mod, Tab, cyclenext"
		"$mod, Tab, bringactivetotop"

		"$mod, H, movefocus, l"
		"$mod, J, movefocus, d"
		"$mod, K, movefocus, u"
		"$mod, L, movefocus, r"

		# "$mod, mouse:272, moveactive"
		# "$mod, Control_L, L, moveactive"
		# "$mod, mouse:273, resizeactive"
		# "$mod Control, resizeactive, -20 0"
		# "$mod, ALT_L, resizeactive, 0 -20"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
          10)
      );
  };
    plugins = [
      # inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
      # inputs.hyprland-plugins.packages.${pkgs.system}.hyprtrails
    ];
  };
}
