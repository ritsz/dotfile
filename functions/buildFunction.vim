" Build current directory. Parent directory on error
function! BuildProj() abort
	AsyncRun clear; python ~/.dotfile/remoteCommands.py 1 %:p
	sleep 5000m
	if g:asyncrun_code == 11
		" chdir to parent directory.
		" We are going to build in parent directory, so errors, if any,
		" get relative path from parent directory. Thus quickfix requires
		" cdpath to be parent directory
		lcd ..
		" Try the parent directory
		AsyncRun clear; python ~/.dotfile/remoteCommands.py 1 %:p:h
	endif
endfunction


