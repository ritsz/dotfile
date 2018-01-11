syntax on
let mapleader=','
set encoding=utf-8
set noexpandtab
set autoindent			" Copy indentation of current line.
set smartindent			" Indentations after new block like {
set cindent				" Use C indentation rules
set tabstop=4
set shiftwidth=4
set softtabstop=0
set nu
set rnu
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
set clipboard=unnamed
set ignorecase			" Ignore case when seaching
set smartcase			" Use smart case for search
set ttyfast				" Fast connection
set title				" Set terminal title 
set completeopt=menu

if has('mouse')
	set mouse=a
endif



"
"Commands
"

function! LoadCscope()
    let db = findfile("cscope.out", ".;")
    if (!empty(db))
        let path = strpart(db, 0, match(db, "/cscope.out$"))
        set nocscopeverbose " suppress 'duplicate connection' error
        exe "cs add " . db . " " . path
        set cscopeverbose
        " else add the database pointed to by
        " environment variable 
        "   elseif $CSCOPE_DB != "" 
        cs add $CSCOPE_DB
    endif
endfunction
au BufEnter /* call LoadCscope()

" Diff of file since last save
function! s:DiffWithSaved()
	let filetype=&ft
	diffthis
	vnew | r # | normal! 1Gdd
	diffthis
	exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

" Load ctags and omnicomplete for C++
function! SetCPPProj()
	set tags+=/BROWSE/tags
	"set omnifunc=omni#cpp#complete#Main
endfunction


""
" Plugins add here
" 
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'                                                             
Plugin 'benmills/vimux'
call vundle#end()            " required
filetype plugin indent on    " required



"
" Set global values
"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
let g:VimuxUseNearest = 0	" Don't use the nearest panel, create a new one
let g:OmniCpp_NamespaceSearch = 1
let g:OmniCpp_GlobalScopeSearch = 1
let g:OmniCpp_ShowAccess = 1
let g:OmniCpp_DisplayMode = 1
let g:OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let g:OmniCpp_MayCompleteDot = 1 " autocomplete after .
let g:OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let g:OmniCpp_MayCompleteScope = 1 " autocomplete after ::

autocmd BufEnter * lcd %:p:h

"
" Keybindings
" 
if has("nvim")
		source ~/.dotfiles/.vimrc-nvim-key
else
		source ~/.dotfiles/.vimrc-vim-key
endif

" Load ctags and omnifunc in C++ files opened
autocmd BufNewFile,BufRead,BufEnter *.cpp,*.hpp,*.h,*.C call SetCPPProj()

