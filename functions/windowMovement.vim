
"
" Function used to split the current window in the desried direction.
" Mapped using Ctrl-h/l/j/k
"
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
