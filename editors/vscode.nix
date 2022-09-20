{ lib, pkgs, ... }:

let
  vars = import ../common/vars.nix;
  vscode-css-peek = pkgs.vscode-utils.extensionFromVscodeMarketplace {
    publisher = "pranaygp";
    name = "vscode-css-peek";
    version = "4.2.0";
    sha256 = "0dpkp3xs8jd826h2aa9xlfilsj4yv8q6r9cs350ljrpcyj7wrlpq";
  };
  html-css-class-completion = pkgs.vscode-utils.extensionFromVscodeMarketplace {
    name = "html-css-class-completion";
    publisher = "Zignd";
    version = "1.20.0";
    sha256 = "1hc2dgib3wryygb36h47wzf32iv1x6rn1swmbgchiyjw62jjj4fw";
  };
  prisma = pkgs.vscode-utils.extensionFromVscodeMarketplace {
    name = "prisma";
    publisher = "Prisma";
    version = "4.3.1"; 
    sha256 = "sha256-IccK7cdW2KjEKlgCC/K7zzs09VvS0fr2TBhR178VX1k";
  };
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
        vscodevim.vim
        vscode-css-peek
        dbaeumer.vscode-eslint
        html-css-class-completion
        christian-kohler.path-intellisense
        prisma
        gruntfuggly.todo-tree 
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
