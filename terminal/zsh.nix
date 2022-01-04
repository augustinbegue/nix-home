{ pkgs, ... }:

{
  programs.zsh = {
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
}
