{ lib, config, pkgs, ... }:

with lib;

let
  mod = "Mod4";
  alt = "Mod1";
  font = "CaskaydiaCove Nerd Font";
  terminal = "alacritty";
  colors = import ./common/colors.nix;
in
{
  home.username = "abegue";
  home.homeDirectory = "/home/abegue";
  home.stateVersion = "21.11";

  imports = [
    ./editors/vscode.nix
    ./editors/vim.nix
    ./x/i3.nix
    ./x/polybar.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  services = {
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

