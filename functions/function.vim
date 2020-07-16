"
"Commands
"

" 
" Highlight searches and active word, and configure how long the active word
" blinks.
"
function! HLNext (blinktime) abort
	let target_pat = '\c\%#'.@/
	let ring = matchadd('ErrorMsg', target_pat, 101)
	redraw
	exec 'sleep ' . float2nr(a:blinktime * 2000) . 'm'
	call matchdelete(ring)
	redraw
endfunction

source ~/.dotfile/functions/buildFunction.vim  
source ~/.dotfile/functions/cscopeHelp.vim     
source ~/.dotfile/functions/cvsHelper.vim      
source ~/.dotfile/functions/formatting.vim
source ~/.dotfile/functions/windowMovement.vim
