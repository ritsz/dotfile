" Diff of file since last save
function! s:DiffWithSaved() abort
	let filetype=&ft
	diffthis
	vnew | r # | normal! 1Gdd
	diffthis
	exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

" Use the downloaded cvs diff file to create a vimdiff
function! s:Cvsdiff(...) abort
	if a:0 > 1
		let rev = a:2
	else
		let rev = ''
	endif

	let ftype = &filetype
	let tmpfile = tempname()
	" Write current file to tmpfile
	let cmd = "cat " . expand("%:p") . " > " . tmpfile  
	let cmd_output = system(cmd)
	if v:shell_error && cmd_output != ""
		echohl WarningMsg | echon cmd_output
		return
	endif

	" Download cvs diff to tmpdiff on localpath.
	let cmd = "python ~/.dotfile/remoteCommands.py 3 " . expand("%:p") . " " . rev
	let cmd_output = system(cmd)
	if v:shell_error && cmd_output != ""
		echohl WarningMsg | echon cmd_output
		return
	endif

	" Reverse patch the tmpfile. This removes the changes in tmpfile
	let cmd = "patch -R -p0 " . tmpfile . " /tmp/tmpdiff"
	let cmd_output = system(cmd)
	if v:shell_error && cmd_output != ""
		echohl WarningMsg | echon cmd_output
		return
	endif

	" Now vimdiff between tmpfile and this file.
	exe "vert diffsplit" . tmpfile
	exe "set filetype=" . ftype

	let cmd = "rm -f tmpdiff"
	let cmd_output = system(cmd)
	if v:shell_error && cmd_output != ""
		echohl WarningMsg | echon cmd_output
		return
	endif
endfunction
com! -bar -nargs=? Cvsdiff :call s:Cvsdiff(<f-args>)


