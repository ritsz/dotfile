
let g:opengrok_project = "main.perforce.1666"

"
" Open the URL in your favorite browse.
"
function! s:url_open(url)
	let s:uri = a:url
	if s:uri != ""
		silent exec "!open '".s:uri."'" | redraw! 
	else
		echo "No URI found in line."
	endif
endfunction

"
" Get the strings under visual selection
"
function! s:get_visual_selection()
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    " let lines[-1] = lines[-1][: column_end - 2]
	let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

"
" Get the string under cursor or visual selection.
"
function! s:get_string_to_search()
	" Visual selection "
	let keyword = s:get_visual_selection()
	
	if len(keyword) == 0
		" Current word "
		let keyword = expand("<cword>")
	endif
	
	if len(keyword) == 0
		return ""
	endif

	return keyword
endfunction

"
" Return URL to search depending on project, searchtype and keyword.
"
function! s:get_complete_url(searchtype, keyword)
	let url = "https://opengrok.eng.vmware.com/source/search?project=" . g:opengrok_project
	if a:searchtype == 1
		let url = url . "&q=\"" . a:keyword . "\"" 
	elseif a:searchtype == 2
		let url = url . "&defs=" . a:keyword
	elseif a:searchtype == 3
		let url = url . "&refs=" . a:keyword
	endif
	echo url
	return url
endfunction

"
" Interface functions: Functions that get called on key mapping and call
" internal helper functions
"


"
" Search the string under cursor or under visual selection
"
function! SearchString()
	let keyword = s:get_string_to_search()
	if len(keyword) == 0
		return 0
	endif
	let url = s:get_complete_url(1, keyword)
	call s:url_open(url)
endfunction

"
" Search the definition of the current word (word on which the cursor is).
"
function! SearchDefinition()
	let keyword = s:get_string_to_search()
	if len(keyword) == 0
		return 0
	endif
	let url = s:get_complete_url(2, keyword)
	call s:url_open(url)
endfunction

"
" Search the symbol of the current word (word on which the cursor is).
"
function! SearchSymbol()
	let keyword = s:get_string_to_search()
	if len(keyword) == 0:
		return 0
	endif
	let url = s:get_complete_url(3, keyword)
	call s:url_open(url)
endfunction
