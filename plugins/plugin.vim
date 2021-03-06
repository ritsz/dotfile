""
" Plugins add here
" 
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()
"Plugin 'Shougo/deoplete.nvim'
"Plugin 'Yggdroot/indentLine'
"Plugin 'bazelbuild/vim-ft-bzl'
"Plugin 'benmills/vimux'
"Plugin 'exclipy/clang_complete'
"Plugin 'hari-rangarajan/CCTree'
"Plugin 'joshdick/onedark.vim'
"Plugin 'kjssad/quantum.vim'
"Plugin 'kristijanhusak/vim-hybrid-material'
"Plugin 'majutsushi/tagbar'
"Plugin 'mtdl9/vim-log-highlighting'
"Plugin 'roxma/nvim-yarp'
"Plugin 'roxma/vim-hug-neovim-rpc'
"Plugin 'sainnhe/vim-color-forest-night'
"Plugin 'severin-lemaignan/vim-minimap'
"Plugin 'sheerun/vim-polyglot'
"Plugin 'skywind3000/asyncrun.vim'
Plugin 'VundleVim/Vundle.vim'
Plugin 'andrewstuart/vim-kubernetes'
Plugin 'ap/vim-buftabline'
Plugin 'chrisbra/vim-diff-enhanced'
Plugin 'easymotion/vim-easymotion'
Plugin 'fatih/vim-go'
Plugin 'jiangmiao/auto-pairs'
Plugin 'junegunn/fzf.vim'
Plugin 'neoclide/coc.nvim', {'branch': 'release'}
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'scrooloose/nerdtree'                                                             
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
call vundle#end()            " required
filetype plugin indent on    " required


"
" Set global values
"
"let g:NERDTreeDirArrowCollapsible = '-'
"let g:NERDTreeDirArrowExpandable = '+'
"let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])
"let g:cpp_class_decl_highlight = 1
"let g:cpp_class_scope_highlight = 1
"let g:cpp_concepts_highlight = 1
"let g:cpp_experimental_simple_template_highlight = 1
"let g:cpp_member_variable_highlight = 1
"let g:deoplete#enable_at_startup = 1
let g:VimuxUseNearest = 0	" Don't use the nearest panel, create a new one
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline_powerline_fonts = 1
let g:go_def_mapping_enabled = 0
