syntax on

let mapleader=','
set autoindent			   " Copy indentation of current line.
set autoread			   " Autodetect and read when file is changed outside
set autowrite			   " Write the contents of the file on buffer changes
set background=dark
set backspace=indent,eol,start
set cindent				   " Use C indentation rules
set clipboard=unnamed
set cmdheight=2         " Better display for messages
set completeopt=menu
set cscopequickfix=s-,c-,d-,i-,t-,e-
set encoding=utf-8
set foldenable          " enable folding
set foldlevel=0
set foldlevelstart=10
set foldmethod=indent   " fold based on indent level
set hidden              " if hidden is not set, TextEdit might fail.
set hlsearch            " highlight matches
set ignorecase			   " Ignore case when seaching
set incsearch           " search as characters are entered
set laststatus=2
set lazyredraw
set modifiable
set nocompatible
set nocscopeverbose
set noexpandtab
set nowrap
set number
set relativenumber      " Causing too many redraws
set ruler
set shiftwidth=4
set shortmess+=c        " don't give |ins-completion-menu| messages.
set showmatch			   " Show matching braces
set signcolumn=yes      " always show signcolumns
set smartcase			   " Use smart case for search
set softtabstop=0
set splitbelow
set splitright
set synmaxcol=200       " Maximum column in which to search for syntax items.
set t_Co=256
set tabstop=4
set title				   " Set terminal title 
set ttyfast				   " Fast connection
set updatetime=300      " Smaller updatetime for CursorHold & CursorHoldI
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
		source ~/.dotfiles/.vimrc-vim-key
else
		source ~/.dotfiles/.vimrc-vim-key
endif

nnoremap <Leader>H :call<SID>LongLineHLToggle()<cr>
hi OverLength ctermbg=none cterm=none
match OverLength /\%>80v/
fun! s:LongLineHLToggle()
    if !exists('w:longlinehl')
        let w:longlinehl = matchadd('ErrorMsg', '.\%>80v', 0)
        echo "Long lines highlighted"
    else
        call matchdelete(w:longlinehl)
        unl w:longlinehl
        echo "Long lines unhighlighted"
    endif
endfunction
