syntax on
let mapleader=','
set encoding=utf-8
set expandtab
set autoindent			" Copy indentation of current line.
set cindent				" Use C indentation rules
set tabstop=3
set shiftwidth=4
set softtabstop=0
set number
set relativenumber
set ruler
set laststatus=2
set backspace=indent,eol,start
set showmatch			" Show matching braces
set nocscopeverbose
set splitright
set splitbelow
set incsearch           " search as characters are entered
set t_Co=256
set background=dark
set hlsearch            " highlight matches
set foldenable          " enable folding
set foldmethod=indent   " fold based on indent level
set foldlevel=0
set foldlevelstart=10
set nocompatible
set modifiable
set autoread			" Autodetect and read when file is changed outside
set autowrite			" Write the contents of the file on buffer changes
set clipboard=unnamed
set ignorecase			" Ignore case when seaching
set smartcase			" Use smart case for search
set ttyfast				" Fast connection
set title				" Set terminal title 
set completeopt=menu
set wildmenu
set nowrap
set cscopequickfix=s-,c-,d-,i-,t-,e-,a-

if has('mouse')
	set mouse=v
endif

"
" Keybindings
" 
if has("nvim")
		source ~/.dotfiles/.vimrc-nvim-key
else
		source ~/.dotfiles/.vimrc-vim-key
endif

"
" Source other modules
"
source ~/.dotfiles/functions/function.vim
source ~/.dotfiles/appearance/appearance.vim
source ~/.dotfiles/plugins/plugin.vim
source ~/.dotfiles/filemanagement/filemanagement.vim

