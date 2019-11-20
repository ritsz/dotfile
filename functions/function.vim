"
"Commands
"

" Highlight searches and active word
function! HLNext (blinktime) abort
	let target_pat = '\c\%#'.@/
	let ring = matchadd('ErrorMsg', target_pat, 101)
	redraw
	exec 'sleep ' . float2nr(a:blinktime * 2000) . 'm'
	call matchdelete(ring)
	redraw
endfunction

function! WinMove(key) abort
	let t:curwin = winnr()
	exec "wincmd ".a:key
	if (t:curwin == winnr())
		if (match(a:key,'[jk]'))
			wincmd v
		else
			wincmd s
		endif
		exec "wincmd ".a:key
	endif
endfunction

source ~/.dotfile/functions/buildFunction.vim  
source ~/.dotfile/functions/cscopeHelp.vim     
source ~/.dotfile/functions/cvsHelper.vim      
source ~/.dotfile/functions/formatting.vim
