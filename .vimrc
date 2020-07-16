" syntax on
" set autoread			" Autodetect and read when file is changed outside
" set autowrite			" Write the contents of the file on buffer changes
" set foldmethod=indent   " fold based on indent level
" set relativenumber : Causing too many redraws
let mapleader=','
set autoindent			" Copy indentation of current line.
set background=dark
set backspace=indent,eol,start
set cindent				" Use C indentation rules
set clipboard=unnamed
set completeopt=menu
set cscopequickfix=s-,c-,d-,i-,t-,e-
set encoding=utf-8
set expandtab
set foldenable          " enable folding
set foldlevel=0
set foldlevelstart=10
set hlsearch            " highlight matches
set ignorecase			" Ignore case when seaching
set incsearch           " search as characters are entered
set laststatus=2
set lazyredraw
set modifiable
set nocompatible
set nocscopeverbose
set nowrap
set number
set ruler
set shiftwidth=4
set showmatch			" Show matching braces
set smartcase			" Use smart case for search
set softtabstop=0
set splitbelow
set splitright
set synmaxcol=200    " Maximum column in which to search for syntax items.
set t_Co=256
set tabstop=3
set title				" Set terminal title 
set ttyfast				" Fast connection
set wildmenu

if has('mouse')
	set mouse=v
endif

"
" Source other modules
"
source ~/.dotfiles/functions/function.vim
source ~/.dotfiles/appearance/appearance.vim
source ~/.dotfiles/plugins/plugin.vim
source ~/.dotfiles/filemanagement/filemanagement.vim

"
" Keybindings
" 
if has("nvim")
		source ~/.dotfiles/.vimrc-nvim-key
else
		source ~/.dotfiles/.vimrc-vim-key
endif
