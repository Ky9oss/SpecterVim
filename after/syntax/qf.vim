" Vim syntax file
" Language:		Quickfix window
" Maintainer:		The Vim Project <https://github.com/vim/vim>
" Last Change:		2025 Feb 07
" Former Maintainer:	Bram Moolenaar <Bram@vim.org>

" Overload syntax
if exists("b:current_syntax")
  syntax clear
endif

syn match	qfFileName	"^[^|]*"	   nextgroup=qfSeparator1
syn match	qfSeparator1	"|"	 contained nextgroup=qfLineNr
syn match	qfLineNr	"[^|]*"	 contained nextgroup=qfSeparator2 contains=@qfType
syn match	qfSeparator2	"|"	 contained nextgroup=qfText

syn match	qfText		".*"	 contained contains=@qfType
syn cluster	qfType	contains=qfError,qfWarning,qfSuccess,qfCtags

syn match	qfError		"error\|Error\|ERROR\|FAILED"	 contained
syn match	qfWarning		"warning"	 contained
syn match	qfSuccess		"SUCCESS"	 contained
syn match	qfCtags		"Tag.*Kind.*File"	 contained
" syn match qfError   /error\|Error\|ERROR/   contained
" syn match qfWarning /warning\|Warning\|WARNING/ contained

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
" hi def link qfText		Normal
" hi def link qfError		Error

" My custom highlight
highlight qfError   guifg=#ff0000 gui=bold ctermfg=Red
highlight qfWarning guifg=#ffaa00 gui=bold ctermfg=Yellow
highlight qfText guifg=#c0caf5 guibg=#1a1b26 ctermfg=White
highlight qfSuccess guifg=#00ff00 gui=bold ctermfg=Green
highlight qfCtags guifg=#ffaa00 gui=bold ctermfg=Yellow

let b:current_syntax = "qf"


" vim: ts=8
