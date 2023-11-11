" General settings
set mouse=a                 " Enable mouse support
set number                  " Show line numbers
set laststatus=2            " Always show status line
set relativenumber          " Relative line numbers
set tabstop=4               " Tab width
set softtabstop=4           " Tab width for Tab key
set shiftwidth=4            " Indent width for << and >>
set expandtab               " Convert Tab to spaces
set autoindent              " Enable auto-indent
set smartindent             " Enable smart auto-indent
set fileformat=unix         " Unix file format

" Autocompletion
set completeopt=menuone,longest,preview
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

" Command history
set history=1000

" Plugin manager
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-surround'       " Surround plugin
Plug 'scrooloose/nerdtree'      " File tree plugin
Plug 'Valloric/YouCompleteMe'   " Autocompletion (for Python)
Plug 'vim-python/python-syntax' " Python syntax

Plug 'morhetz/gruvbox'  " colorscheme gruvbox
" Plug 'mhartington/oceanic-next'  " colorscheme OceanicNext
" Plug 'kaicataldo/material.vim'  "material
" Plug 'ayu-theme/ayu-vim' "ayu-vim

call plug#end()

" Color scheme
syntax on
colorscheme gruvbox

" NERDTree settings
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | wincmd p | endif

" Plugin-specific commands
let g:python_highlight_all = 1

" Python-specific optimization
autocmd FileType python setlocal shiftwidth=4 tabstop=4

