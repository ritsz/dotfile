" Format the changes
function! s:ClangFormat() abort
	" Copy format file 
	let cmd = "cp ~/.dotfile/.clang-format " . expand("%:p:h")
	let cmd_output = system(cmd)
	if v:shell_error && cmd_output != ""
		echohl WarningMsg | echon cmd_output
		return
	endif

	" clang-format the file
	let cmd = "clang-format " . expand("%") . " > " . expand("%") . "_format"
	let cmd_output = system(cmd)
	if v:shell_error && cmd_output != ""
		echohl WarningMsg | echon cmd_output
		return
	endif

	" Move format file over current file
	let cmd = "mv " . expand("%") . "_format " . expand("%")
	let cmd_output = system(cmd)
	if v:shell_error && cmd_output != ""
		echohl WarningMsg | echon cmd_output
		return
	endif

	exec "edit!"
endfunction
com! ClangFormat call s:ClangFormat()


