{ pkgs, ... }:

{
  home.username = "abegue";
  home.homeDirectory = "/home/abegue";
  home.stateVersion = "21.11";

  imports = [
    ./editors/vscode.nix
    ./editors/vim.nix
    ./x/i3.nix
    ./x/polybar.nix
    ./terminal/alacritty.nix
    ./terminal/zsh.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    mailspring
    jetbrains.idea-ultimate
    jdk
    texlive.combined.scheme-full
    i3lock-fancy-rapid
  ];

  services = {
    picom = {
      enable = true;

      blur = true;

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
    rofi = {
      enable = true;
    };
    htop = {
      enable = true;
      settings = {
        left_meters = [ "LeftCPUs2" "Memory" "Swap" ];
        left_right = [ "RightCPUs2" "Tasks" "LoadAverage" "Uptime" ];
        setshowProgramPath = false;
        treeView = true;
      };
    };
  };
}

