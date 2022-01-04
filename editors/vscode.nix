{ lib, pkgs, ... }:

let vars = import ../common/vars.nix;
in
{
  programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        zhuangtongfa.material-theme
        ms-vscode.cpptools
        svelte.svelte-vscode
      ];
      userSettings = {
        "workbench.colorTheme" = "One Dark Pro";
        "editor.fontFamily" = vars.font;
        "editor.fontSize" = 18;
        "editor.fontLigatures" = true;
        "window.menuBarVisibility" = "toggle";
      };
    };
}