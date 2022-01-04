{ lib, pkgs, ... }:

{
  programs.vim = {
    enable = true;

    plugins = with pkgs.vimPlugins; [ 
      vim-airline
      onedark-vim
      vim-gitgutter
      vim-polyglot
      ];

    settings = {
      ignorecase = true;
    };

    extraConfig = ''
      " remove annoying beep
      set belloff=all

      " set encoding
      set encoding=utf-8 fileencodings=

      " Shows matching brackets
      set showmatch 

      " set visible trailing characters
      set list listchars=tab:»\ ,trail:·

      " if you really want to use the mouse
      set mouse=a
      set ttymouse=sgr " wide monitor mouse fix

      " set numbers on the left
      set number

      " set line at 80 char
      set cc=80

      " indentation
      filetype plugin indent on
      set autoindent
      set smartindent

      " set tab size
      set expandtab
      set shiftwidth=4
      set tabstop=4
      set softtabstop=4

      " custom shotcuts
      let mapleader="\<Space>"
      nnoremap <Space> <nop>
      nnoremap <Leader>f :Explore<CR>
      nnoremap <Leader>w :w<CR>

      " c braces setup
      inoremap {<CR> {<CR>}<Esc>ko

      " reduce latency when escaping
      set ttimeoutlen=10

      " makefiles settings
      autocmd Filetype make setlocal noexpandtab

      " c files
      autocmd BufRead,BufNewFile *.c,*.h setlocal cinoptions+=:0 " case statement indent fix
      autocmd BufRead,BufNewFile *.c,*.h setlocal comments=s:/**,mb:**,ex:*/,s:/*,mb:**,ex:*/

      " colorscheme
      packadd! onedark.vim
      syntax on
      colorscheme onedark

      " packages ?
      packadd! vim-airline
      packadd! vim-gitgutter
      packadd! vim-polyglot

      packadd termdebug
    '';
  };
}
