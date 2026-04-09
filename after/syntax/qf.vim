" Vim syntax file
" Language:		Quickfix window
" Maintainer:		Ky9oss
"
" I just realized I need to become a damn syntax expert to master this shit 0_0

" Overload syntax
if exists("b:current_syntax")
  syntax clear
endif

syn match	qfFileName	"^[^|]*"	   nextgroup=qfSeparator1
syn match	qfSeparator1	"|"	 contained nextgroup=qfLineNr
syn match	qfLineNr	"[^|]*"	 contained nextgroup=qfSeparator2 contains=@qfType
syn match	qfSeparator2	"|"	 contained nextgroup=qfTitle

" syn match	qfTitle		".*|[\s]*"	 contained nextgroup=qfText contains=qfCtags,qfSeparator3,qfCtagsText 
syn match	qfTitle		".*"	 contained nextgroup=qfText contains=qfCtags,qfSeparator3,qfCtagsText 

syn match	qfSeparator3	"|"	contained
syn match	qfCtags		"\%1l[^|]*"	 contained
syn match	qfCtagsText		"\%>1l.*"	 contained contains=@qfType

" Normal text and Make compilation results
syn match	qfText		".*"	 contained contains=@qfType
syn cluster	qfType	contains=qfError,qfSuccess,qfWarning

syn match	qfError		"error\|Error\|ERROR\|FAILED"	 contained
syn match	qfWarning		"warning"	 contained
syn match	qfSuccess		"SUCCESS"	 contained


" Hide file name and line number for help outline (TOC).
if has_key(w:, 'qf_toc') || get(w:, 'quickfix_title') =~# '\<TOC$\|\<Table of contents\>'
  setlocal conceallevel=3 concealcursor=nc
  syn match	Ignore		"^[^|]*|[^|]*| " conceal
endif

" The default highlighting.
hi def link qfFileName		Directory
hi def link qfLineNr		LineNr
hi def link qfSeparator1	Delimiter
hi def link qfSeparator2	Delimiter
hi def link qfSeparator3	Delimiter
" hi def link qfText		Normal
" hi def link qfError		Error

" My custom highlight
highlight qfText guifg=#c0caf5 guibg=#1a1b26 ctermfg=White
highlight qfTitle guifg=#c0caf5 guibg=#1a1b26 ctermfg=White
highlight qfError   guifg=#ff0000 gui=bold ctermfg=Red
highlight qfWarning guifg=#ffaa00 gui=bold ctermfg=Yellow
highlight qfSuccess guifg=#00ff00 gui=bold ctermfg=Green

highlight qfCtagsText guifg=#c0caf5 guibg=#1a1b26 ctermfg=White
highlight qfCtags guifg=#ffaa00 gui=bold ctermfg=Yellow


let b:current_syntax = "qf"


" vim: ts=8
