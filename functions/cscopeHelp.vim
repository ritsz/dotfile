function! LoadCscope() abort
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

" Load ctags and omnicomplete for C++
function! SetCPPProj()
	set tags+=/BROWSE/tags
	cs add /BROWSE/cscope.out
endfunction

" Load ctags and omnifunc in C++ files opened
autocmd BufNewFile,BufRead,BufEnter *.src,*.cmd,*.cpp,*.hpp,*.h,*.C call SetCPPProj()


