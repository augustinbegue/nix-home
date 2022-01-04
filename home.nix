{ lib, config, pkgs, ... }:

with lib;

let
  mod = "Mod4";
  alt = "Mod1";
  font = "CaskaydiaCove Nerd Font";
  terminal = "alacritty";
  _colors = import ./common/colors.nix;
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
    zsh = {
      enable = true;

      autocd = true;

      shellAliases = {
        ls = "ls -la";
      };

      initExtra = ''
        # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      '';

      plugins = [
        {
          name = "zsh-autosuggestions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "v0.7.0";
            sha256 = "0z6i9wjjklb4lvr7zjhbphibsyx51psv50gm07mbb0kj9058j6kc";
          };
          file = "zsh-autosuggestions.zsh";
        }
        {
          name = "zsh-syntax-highlighting";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-syntax-highlighting";
            rev = "0.6.0";
            sha256 = "0zmq66dzasmr5pwribyh4kbkk23jxbpdw4rjxx0i7dx8jjp2lzl4";
          };
          file = "zsh-syntax-highlighting.zsh";
        }
        {
          name = "enhancd";
          src = pkgs.fetchFromGitHub {
            owner = "b4b4r07";
            repo = "enhancd";
            rev = "v2.2.4";
            sha256 = "1smskx9vkx78yhwspjq2c5r5swh9fc5xxa40ib4753f00wk4dwpp";
          };
          file = "init.sh";
        }
      ];

      oh-my-zsh = {
        enable = true;

        plugins = [
          "git"
          "sudo"
        ];
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
    rofi = {
      enable = true;
    };
  };
}

