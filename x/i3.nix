{ lib, pkgs, ... }:

let _colors = import ../common/colors.nix;
    vars = import ../common/vars.nix;
    mod = vars.mod;
    alt = vars.alt;
in
{
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;

    config = rec {
      modifier = mod;

      startup = [
        {
          command = "${pkgs.feh}/bin/feh --no-startup-id --bg-scale ~/.config/wallpaper.jpg";
          always = true;
          notification = true;
        }
        {
          command = "${pkgs.flameshot}/bin/flameshot";
          always = true;
          notification = true;
        }
        {
          command = "~/.config/polybar/launch.sh";
          always = true;
          notification = true;
        }
      ];

      fonts = {
        names = [ vars.font ];
        style = "Regular";
        size = 12.0;
      };

      gaps = {
        inner = 6;
        outer = 2;
      };

      keybindings = {
        "${mod}+Return" = "exec ${vars.terminal}";
        "${mod}+Shift+q" = "kill";
        "${mod}+d" = "exec $HOME/.config/rofi/launcher.sh";

        # Brightness Control
        "XF86MonBrightnessDown" = "exec --no-startup-id light -U 5";
        "XF86MonBrightnessUp" = "exec --no-startup-id light -A 5";

        # Lock
        "${mod}+l" = "exec --no-startup-id i3lock-fancy-rapid 5 3";

        # Sound Control
        "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86AudioMicMute" = "exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle";

        "XF86AudioPlay" = "exec --no-startup-id dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Play";
        "XF86AudioPause" = "exec --no-startup-id dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Pause";

        # Select/Move focused window
        "${mod}+Left" = "focus left";
        "${mod}+Down" = "focus down";
        "${mod}+Up" = "focus up";
        "${mod}+Right" = "focus right";

        "${mod}+Shift+Left" = "move left";
        "${mod}+Shift+Down" = "move down";
        "${mod}+Shift+Up" = "move up";
        "${mod}+Shift+Right" = "move right";

        # Change focused tab (alt tab)
        "${alt}+Tab" = "focus next";
        "${alt}+Shift+Tab" = "focus prev";

        # Layout toggles
        "${mod}+h" = "split h";
        "${mod}+v" = "split v";
        "${mod}+f" = "fullscreen toggle";
        "${mod}+s" = "layout stacking";
        "${mod}+w" = "layout tabbed";
        "${mod}+e" = "layout toggle split";

        "${mod}+Shift+space" = "floating toggle";
        "${mod}+space" = "focus mode_toggle";

        "${mod}+a" = "focus parent";

        "${mod}+1" = "workspace number 1";
        "${mod}+2" = "workspace number 2";
        "${mod}+3" = "workspace number 3";
        "${mod}+4" = "workspace number 4";
        "${mod}+5" = "workspace number 5";
        "${mod}+6" = "workspace number 6";
        "${mod}+7" = "workspace number 7";
        "${mod}+8" = "workspace number 8";
        "${mod}+9" = "workspace number 9";
        "${mod}+0" = "workspace number 10";

        "${mod}+Shift+1" = "move container to workspace number 1";
        "${mod}+Shift+2" = "move container to workspace number 2";
        "${mod}+Shift+3" = "move container to workspace number 3";
        "${mod}+Shift+4" = "move container to workspace number 4";
        "${mod}+Shift+5" = "move container to workspace number 5";
        "${mod}+Shift+6" = "move container to workspace number 6";
        "${mod}+Shift+7" = "move container to workspace number 7";
        "${mod}+Shift+8" = "move container to workspace number 8";
        "${mod}+Shift+9" = "move container to workspace number 9";
        "${mod}+Shift+0" = "move container to workspace number 10";

        "${mod}+Shift+c" = "reload";
        "${mod}+Shift+r" = "restart";
        "${mod}+Shift+e" = "exec i3-nagbar -t warning -m 'Do you want to exit i3?' -b 'Yes' 'i3-msg exit'";

        "${mod}+r" = "mode resize";
      };

      window.commands = [
        { command = "border pixel 0"; criteria = { class = "^.*"; }; }
      ];

      colors = {
        focused = {
          border = "${_colors.background-alt}";
          background = "${_colors.background-alt}";
          text = "${_colors.foreground}";
          indicator = "${_colors.background}";
          childBorder = "${_colors.background}";
        };

        focusedInactive = {
          border = "${_colors.background}";
          background = "${_colors.background}";
          text = "${_colors.foreground}";
          indicator = "${_colors.background}";
          childBorder = "${_colors.background}";
        };

        unfocused = {
          border = "${_colors.background}";
          background = "${_colors.background}";
          text = "${_colors.background-alt}";
          indicator = "${_colors.background}";
          childBorder = "${_colors.background}";
        };

        urgent = {
          border = "${_colors.background}";
          background = "${_colors.background}";
          text = "#E06C75";
          indicator = "#900000";
          childBorder = "#900000";
        };

        placeholder = {
          border = "#0c0c0c";
          background = "#0c0c0c";
          text = "${_colors.foreground}";
          indicator = "#000000";
          childBorder = "#0c0c0c";
        };
      };

      bars = [ ];
    };

    extraConfig = "smart_gaps inverse_outer";
  };
}
