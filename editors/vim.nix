{ lib, pkgs, ... }:

{
  programs.vim = {
    enable = true;

    plugins = with pkgs.vimPlugins; [ 
      onehalf
      vim-polyglot
      vim-airline
    ];

    settings = {
      number = true;
      background = "dark";
    };

    extraConfig = ''
    "One Half Dark Theme
    syntax on
    set t_Co=256
    set cursorline
    colorscheme onehalfdark
    let g:airline_theme='onehalfdark'
    " lightline
    " let g:lightline = { 'colorscheme': 'onehalfdark' }
    if exists('+termguicolors')
      let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
      set termguicolors
    endif
    '';
  };
}
