" Vim syntax file
" Language:		Quickfix window
" Maintainer:		Ky9oss
"
" I just realized I need to become a damn syntax expert to master this shit 0_0

" Quit when a syntax file was already loaded
" Do not overload by `syntax clear`. This might cause undefined behavior
if exists("b:current_syntax")
  echo "SpecterVim: The syntax setting failed because qf.vim has loaded. Check runtimepath and remove it."
  finish
endif

syn match	qfFileName	"^[^|]*"	   nextgroup=qfSeparator1
syn match	qfSeparator1	"[|]?"	 contained nextgroup=qfLineNr
syn match	qfLineNr	"[^|]*"	 contained nextgroup=qfSeparator2
syn match	qfSeparator2	"[|]?"	 contained nextgroup=qfText


syn match	qfError		"error\|Error\|ERROR\|FAILED"
syn match	qfWarning		"warning"
syn match	qfSuccess		"SUCCESS"
" syn cluster	qfType	contains=qfError,qfSuccess,qfWarning

syn match	qfSeparator	"|"

" 注意：多个syn match之间会互相覆盖，导致高亮缺失
" 使用contains可以解决问题。可以理解为contains中的规则优先级更高
syn match	qfCtags		/\%1l[^c][^|]*|/he=e-1  contains=qfSeparator

syn match	qfText		".*" contained contains=qfError,qfWarning,qfSuccess,qfCtags,qfSeparator


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

" My custom highlight
highlight qfText guifg=#c0caf5 guibg=#1a1b26 ctermfg=White
highlight qfError   guifg=#ff0000 gui=bold ctermfg=Red
highlight qfWarning guifg=#ffaa00 gui=bold ctermfg=Yellow
highlight qfSuccess guifg=#00ff00 gui=bold ctermfg=Green
hi def link qfSeparator	Delimiter
highlight qfCtags guifg=#ffaa00 gui=bold ctermfg=Yellow


let b:current_syntax = "qf"


" vim: ts=8
