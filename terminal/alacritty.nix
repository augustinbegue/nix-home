{pkgs, ...}:
let
  _colors = import ../common/colors.nix;
  vars = import ../common/vars.nix;
in
{
  programs.alacritty = {
      enable = true;
      settings = {
        font = {
          normal = {
            family = vars.font;
          };

          size = 7;

          offset = {
            x = 0;
            y = 0;
          };

          glyph_offset = {
            x = 0;
            y = 0;
          };
        };

        window = {
          padding = {
            x = 4;
            y = 4;
          };
        };

        colors = {
          # Default colors
          primary = {
            background = "${_colors.background}";
            foreground = "${_colors.foreground}";

            # Bright and dim foreground colors
            #
            # The dimmed foreground color is calculated automatically if it is not present.
            # If the bright foreground color is not set, or `draw_bold_text_with_bright_colors`
            # is `false`, the normal foreground color will be used.
            #dim_foreground: "0x9a9a9a"
            bright_foreground = "${_colors.foreground-alt}";
          };

          # Normal colors
          normal = {
            black = "${_colors.background}";
            red = "${_colors.alert}";
            green = "${_colors.success}";
            yellow = "${_colors.warning}";
            blue = "${_colors.primary}";
            magenta = "${_colors.magenta}";
            cyan = "${_colors.secondary}";
            white = "${_colors.foreground}";
          };

          # Bright colors
          bright = {
            black = "${_colors.background}";
            red = "${_colors.alert}";
            green = "${_colors.success}";
            yellow = "${_colors.warning}";
            blue = "${_colors.primary}";
            magenta = "${_colors.magenta}";
            cyan = "${_colors.secondary}";
            white = "${_colors.foreground}";
          };
        };
      };
    };
}