
"if has("gui_running")
"	colorscheme default
"	set guifont=Monospace\ 12
"else
"	colorscheme forest-night
" 	colorscheme dracula
"	colorscheme hybrid_reverse
"	colorscheme onedark
"endif
"
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
   let l:branchname = GitBranch()
   return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline=
set statusline+=%#LineNr#
"set statusline+=%{StatuslineGit()}
set statusline+=%#PmenuSel#
set statusline+=\ %f
set statusline+=\ [%{&fileformat}\]
"set statusline+=%m\
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\ 
