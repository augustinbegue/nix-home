{ lib, config, pkgs, ... }:

with lib;

let
  mod = "Mod4";
  alt = "Mod1";
  font = "CaskaydiaCove Nerd Font";
  terminal = "alacritty";
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "abegue";
  home.homeDirectory = "/home/abegue";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

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
        names = [ font ];
        style = "Regular";
        size = 12.0;
      };

      gaps = {
        inner = 6;
        outer = 2;
      };

      keybindings = {
        "${mod}+Return" = "exec ${terminal}";
        "${mod}+Shift+q" = "kill";
        "${mod}+d" = "exec $HOME/.config/rofi/launchers/colorful/launcher.sh";

        # Brightness Control
        "XF86MonBrightnessDown" = "exec --no-startup-id light -U 5";
        "XF86MonBrightnessUp" = "exec --no-startup-id light -A 5";

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
          border = "#434954";
          background = "#434954";
          text = "#ffffff";
          indicator = "#282C34";
          childBorder = "#282C34";
        };

        focusedInactive = {
          border = "#282C34";
          background = "#282C34";
          text = "#ffffff";
          indicator = "#282C34";
          childBorder = "#282C34";
        };

        unfocused = {
          border = "#282C34";
          background = "#282C34";
          text = "#434954";
          indicator = "#282C34";
          childBorder = "#282C34";
        };

        urgent = {
          border = "#282C34";
          background = "#282C34";
          text = "#E06C75";
          indicator = "#900000";
          childBorder = "#900000";
        };

        placeholder = {
          border = "#0c0c0c";
          background = "#0c0c0c";
          text = "#ffffff";
          indicator = "#000000";
          childBorder = "#0c0c0c";
        };
      };

      bars = [ ];
    };

    extraConfig = "smart_gaps inverse_outer";
  };

  services = {
    polybar = {
      enable = true;

      package = pkgs.polybar.override {
        i3GapsSupport = true;
        alsaSupport = true;
      };

      settings =
        let colors = {
          background = "#282C34";
          background-alt = "#434954";
          foreground = "#ffffff";
          foreground-alt = "#dfdfdf";
          primary = "#61AFEF";
          secondary = "#56B6C2";
          alert = " #E06C75";
          warning = "#E5C07B";
          success = "#98C379";
        }; in
        {
          "bar/desktop" = {
            width = "100%";
            height = "28";
            #;offset-x = 1%
            #;offset-y = 1%
            radius = "0.0";
            fixed-center = "false";

            background = "${colors.background}";
            foreground = "${colors.foreground}";

            line-size = "3";
            line-color = "#f00";

            border-top-size = "0";
            border-bottom-size = "0";
            border-right-size = "6";
            border-left-size = "6";
            border-color = "#00FFFFFF";

            padding-left = "0";
            padding-right = "2";

            module-margin-left = "1";
            module-margin-right = "1";

            font-0 = "${font}:pixelsize=12";

            modules-left = "i3";
            modules-center = "mpd";
            modules-right = "filesystem backlight-acpi pulseaudio wlan cpu memory temperature battery date powermenu";

            tray-position = "right";
            tray-padding = "2";

            cursor-click = "pointer";
            cursor-scroll = "ns-resize";
          };

          "module/xwindow" = {
            type = "internal/xwindow";
            label = "%title:0:30:...%";
          };

          "module/filesystem" = {
            type = "internal/fs";
            interval = "60";
            fixed-values = "true";

            mount-0 = "/";

            label-mounted = "%{F#61AFEF}%mountpoint%%{F-}: %used%/%total%";
            label-unmounted = "%mountpoint% not mounted";
            label-unmounted-foreground = "${colors.foreground-alt}";
          };

          "module/i3" = {
            type = "internal/i3";
            format = "<label-state> <label-mode>";
            index-sort = "true";
            wrapping-scroll = "false";

            #Only show workspaces on the same output as the bar
            #pin-workspaces = true

            label-mode-padding = "2";
            label-mode-foreground = "#000";
            label-mode-background = "${colors.primary}";

            # focused = Active workspace on focused monitor
            label-focused = "%index%";
            label-focused-background = "${colors.background-alt}";
            label-focused-underline = "${colors.primary}";
            label-focused-padding = "2";

            # unfocused = Inactive workspace on any monitor
            label-unfocused = "%index%";
            label-unfocused-padding = "1";

            # visible = Active workspace on unfocused monitor
            label-visible = "%index%";
            label-visible-background = "\${self.label-focused-background}";
            label-visible-underline = "\${self.label-focused-underline}";
            label-visible-padding = "\${self.label-focused-padding}";

            # urgent = Workspace with urgency hint set
            label-urgent = "%index%";
            label-urgent-background = "${colors.alert}";
            label-urgent-padding = "2";

            # Separator in between workspaces
            # label-separator = "|";
          };

          "module/mpd" = {
            type = "internal/mpd";
            format-online = "<label-song>  <icon-prev> <icon-stop> <toggle> <icon-next>";

            icon-prev = "玲";
            icon-stop = "栗";
            icon-play = "";
            icon-pause = "";
            icon-next = "怜";

            label-song-maxlen = "25";
            label-song-ellipsis = "true";
          };

          "module/xbacklight" = {
            type = "internal/xbacklight";

            format = "<label> <bar>";

            bar-width = "5";
            bar-indicator = "盛";
            bar-indicator-foreground = "${colors.foreground}";
            bar-indicator-font = "2";
            bar-fill = "─";
            bar-fill-font = "2";
            bar-fill-foreground = "${colors.primary}";
            bar-empty = "─";
            bar-empty-font = "2";
            bar-empty-foreground = "${colors.foreground-alt}";
          };

          "module/backlight-acpi" = {
            "inherit" = "module/xbacklight";
            type = "internal/backlight";
            card = "amdgpu_bl0";
          };

          "module/cpu" = {
            type = "internal/cpu";
            interval = "1";

            label = "%percentage:2%%";

            format = "<label> <ramp-coreload>";
            format-underline = "${colors.primary}";

            ramp-coreload-spacing = "0";
            ramp-coreload = [ "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
          };

          "module/memory" = {
            type = "internal/memory";
            interval = "2";
            format-prefix = " ";
            format-prefix-foreground = "${colors.foreground-alt}";
            format-underline = "${colors.primary}";
            label = "%percentage_used%%";
          };

          "module/wlan" = {
            type = "internal/network";
            interface = "wlp1s0";
            interval = "3.0";

            format-connected = "<ramp-signal> <label-connected>";
            format-connected-underline = "${colors.primary}";
            label-connected = "%essid%";

            format-disconnected = "";
            #format-disconnected = <label-disconnected>
            #format-disconnected-underline = ${self.format-connected-underline}
            #label-disconnected = %ifname% disconnected
            #label-disconnected-foreground = ${colors.foreground-alt}

            ramp-signal = [ "直" "直" "直" "直" "直" ];
            ramp-signal-foreground = "${colors.foreground-alt}";
          };

          "module/eth" = {
            type = "internal/network";
            interface = "eno1";
            interval = "3.0";

            format-connected-underline = "#55aa55";
            format-connected-prefix = " ";
            format-connected-prefix-foreground = "${colors.foreground-alt}";
            label-connected = "%local_ip%";

            format-disconnected = "";
            # ;format-disconnected = <label-disconnected>
            # ;format-disconnected-underline = ${self.format-connected-underline}
            # ;label-disconnected = %ifname% disconnected
            # ;label-disconnected-foreground = ${colors.foreground-alt}
          };

          "module/date" = {
            type = "internal/date";
            interval = "1";

            date = "";
            date-alt = " %Y-%m-%d";

            time = "%H:%M:%S";
            time-alt = "%H:%M:%S";

            format-prefix = "";
            format-prefix-foreground = "${colors.foreground-alt}";
            format-underline = "${colors.primary}";

            label = "%date% %time%";
          };

          "module/pulseaudio" = {
            type = "internal/pulseaudio";

            format-volume = "<label-volume> <bar-volume>";
            label-volume = "墳 %percentage%%";
            label-volume-foreground = "${colors.primary}";

            label-muted = "ﱝ muted";
            label-muted-foreground = "#666";

            bar-volume-width = "10";
            bar-volume-foreground = [ "${colors.primary}" "${colors.primary}" "${colors.primary}" "${colors.primary}" "${colors.primary}" "${colors.primary}" "${colors.primary}" ];
            bar-volume-gradient = "false";
            bar-volume-indicator = "|";
            bar-volume-indicator-font = "2";
            bar-volume-fill = "─";
            bar-volume-fill-font = "2";
            bar-volume-empty = "─";
            bar-volume-empty-font = "2";
            bar-volume-empty-foreground = "${colors.foreground-alt}";
          };

          "module/battery" = {
            type = "internal/battery";
            battery = "BAT0";
            adapter = "AC";
            full-at = "98";

            format-charging = "<animation-charging> <label-charging>";
            format-charging-underline = "${colors.success}";

            format-discharging = "<animation-discharging> <label-discharging>";
            format-discharging-underline = "${colors.warning}";

            format-full-prefix = " ";
            format-full-prefix-foreground = "${colors.foreground-alt}";
            format-full-underline = "${colors.success}";

            ramp-capacity = [ "" "" "" ];
            ramp-capacity-foreground = "${colors.foreground-alt}";

            animation-charging = [ "" "" "" "" "" "" "" "" "" ];
            animation-charging-foreground = "${colors.foreground-alt}";
            animation-charging-framerate = "300";

            animation-discharging = [ "" "" "" "" "" "" "" "" "" ];
            animation-discharging-foreground = "${colors.foreground-alt}";
            animation-discharging-framerate = "300";
          };

          "module/temperature" = {
            type = "internal/temperature";
            thermal-zone = "1";
            warn-temperature = "60";

            format = "<ramp> <label>";
            format-underline = "${colors.primary}";
            format-warn = "<ramp> <label-warn>";
            format-warn-underline = "${colors.alert}";

            label = "%temperature-c%";
            label-warn = "%temperature-c%";
            label-warn-foreground = "${colors.alert}";

            ramp-0 = "";
            ramp-1 = "";
            ramp-2 = "";
            ramp-foreground = "${colors.foreground-alt}";
          };

          "module/powermenu" = {
            type = "custom/menu";

            expand-right = "true";

            format-spacing = "1";

            label-open = "⏻";
            label-open-foreground = "${colors.foreground}";
            label-close = "cancel";
            label-close-foreground = "${colors.warning}";
            label-separator = "|";
            label-separator-foreground = "${colors.foreground-alt}";

            menu-0-0 = "reboot";
            menu-0-0-exec = "reboot";
            menu-0-1 = "power off";
            menu-0-1-exec = "menu-open-2";

            menu-1-0 = "cancel";
            menu-1-0-exec = "menu-open-0";
            menu-1-1 = "reboot";
            menu-1-1-exec = "reboot";

            menu-2-0 = "power off";
            menu-2-0-exec = "shutdown now";
            menu-2-1 = "cancel";
            menu-2-1-exec = "menu-open-0";
          };

          "settings" = {
            screenchange-reload = "true";
            # ;compositing-background = xor
            compositing-background = "screen";
            compositing-foreground = "source";
            compositing-border = "over";
            pseudo-transparency = "false";
          };
        };

      script = "";
    };

    picom = {
      enable = true;

      blur = false;

      shadow = false;

      fade = true;
      fadeDelta = 4;

      backend = "glx";

      inactiveOpacity = "0.95";
      extraOptions = ''
        blur-background = true;
        blur-background-fixed = true;
        blur-strength = 8;
        blur-size = 20;
      '';
    };

    mpris-proxy = {
      enable = true;
    };
  };

  programs = {
    vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        zhuangtongfa.material-theme
        ms-vscode.cpptools
        svelte.svelte-vscode
      ];
      userSettings = {
        "workbench.colorTheme" = "One Dark Pro";
        "editor.fontFamily" = font;
        "editor.fontSize" = 18;
        "editor.fontLigatures" = true;
        "window.menuBarVisibility" = "toggle";
      };
    };
    alacritty = {
      enable = true;
      settings = {
        font = {
          normal = {
            family = font;
          };
          size = 7;
          # Colors (Tomorrow Night)
          colors = {
            # Default colors
            primary = {
              background = "0x282C34";
              foreground = "0xabb2bf";

              # Bright and dim foreground colors
              #
              # The dimmed foreground color is calculated automatically if it is not present.
              # If the bright foreground color is not set, or `draw_bold_text_with_bright_colors`
              # is `false`, the normal foreground color will be used.
              #dim_foreground: "0x9a9a9a"
              bright_foreground = "0xe6efff";
            };

            # Normal colors
            normal = {
              black = "0x1e2127";
              red = "0xe06c75";
              green = "0x98c379";
              yellow = "0xd19a66";
              blue = "0x61afef";
              magenta = "0xc678dd";
              cyan = "0x56b6c2";
              white = "0x828791";
            };

            # Bright colors
            bright = {
              black = "0x5c6370";
              red = "0xe06c75";
              green = "0x98c379";
              yellow = "0xd19a66";
              blue = "0x61afef";
              magenta = "0xc678dd";
              cyan = "0x56b6c2";
              white = "0xe6efff";
            };
          };
        };
      };
    };
    rofi = {
      enable = true;
    };
  };
}

