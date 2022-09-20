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
        bradlc.vscode-tailwindcss
        esbenp.prettier-vscode
        eamodio.gitlens
        github.copilot
        james-yu.latex-workshop
      ];
      userSettings = {
        "workbench.colorTheme" = "One Dark Pro";
        "editor.fontFamily" = vars.font;
        "editor.fontSize" = 16;
        "editor.fontLigatures" = true;
        "editor.formatOnSave" = true;
        "window.menuBarVisibility" = "toggle";
      };
    };
}
