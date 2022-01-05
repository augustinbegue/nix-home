{ lib, pkgs, ... }:

{
  programs.vim = {
    enable = true;

    plugins = with pkgs.vimPlugins; [ 
      onehalf
      indentLine
      vim-polyglot
      vim-signify
      vim-airline
      vim-airline-themes
    ];

    settings = {
      number = true;
      background = "dark";
    };

    extraConfig = ''
    "Indentation Guides
    set list lcs=tab:\|\
    set cursorline

    "One Half Dark Theme
    syntax on
    set t_Co=256
    colorscheme onehalfdark
    let g:airline_powerline_fonts=1
    let g:airline_theme='onehalfdark'
    " lightline
    let g:lightline = { 'colorscheme': 'onehalfdark' }
    if exists('+termguicolors')
      let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
      set termguicolors
    endif
    '';
  };
}
