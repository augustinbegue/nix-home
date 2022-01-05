{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    autocd = true;

    shellAliases = {
      ls = "n";
    };
 
    initExtra = ''
      # nnn options
      export NNN_OPTS="dHeio"
      export NNN_COLORS="1234"

      n ()
      {
          # Block nesting of nnn in subshells
          if [ -n $NNNLVL ] && [ "''${NNNLVL:-0}" -ge 1 ]; then
            echo "nnn is already running"
            return
          fi

          # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
          # To cd on quit only on ^G, either remove the "export" as in:
          #    NNN_TMPFILE="''${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
          #    (or, to a custom path: NNN_TMPFILE=/tmp/.lastd)
          # or, export NNN_TMPFILE after nnn invocation
          export NNN_TMPFILE="''${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

          # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
          # stty start undef
          # stty stop undef
          # stty lwrap undef
          # stty lnext undef

          nnn "$@"

          if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
          fi
      }
    
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
