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
	set tags+=$CSCOPE_DB_DIR/tags
	cs add $CSCOPE_DB
endfunction

" Load ctags and omnifunc in C++ files opened

augroup DEV
   autocmd!
   autocmd BufEnter * lcd %:p:h
"   if !&diff
"      "autocmd BufEnter *.java,*.py,*.c,*.cpp,*.h TagbarOpen
"      autocmd BufEnter *.log,*.src,*.cmd,*.cpp,*.hpp,*.h,*.C,*.py,*.java call SetCPPProj()
"      "autocmd BufNewFile,BufRead *.log set wrap
"      "autocmd BufNewFile,BufRead *.bzl,*.bazel set ts=4
"   endif
augroup END
