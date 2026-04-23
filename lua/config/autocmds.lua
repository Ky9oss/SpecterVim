require("utils.lsp")
local project = require("project_nvim.project")
local project_root = project.get_project_root()

-- auto open nvim-tree
vim.api.nvim_create_autocmd({ "VimEnter" }, {
	callback = function()
		vim.g.opened_with_file = vim.fn.argc() > 0
		vim.g.opened_with_man = vim.bo.filetype == "man" and vim.fn.argc() == 0
		-- if vim.g.opened_with_man then
		-- 	vim.cmd("set relativenumber")
		-- end
		if not vim.g.opened_with_file and not vim.g.opened_with_man then
			require("nvim-tree.api").tree.open()
		end
	end,
})

-- auto change CRLF to LF
vim.api.nvim_create_autocmd("BufWrite", {
	pattern = "*",
	callback = function()
		if vim.bo.fileformat == "dos" then
			vim.bo.fileformat = "unix"
		end
	end,
})

-- auto save draftpaper and temp scripts
vim.api.nvim_create_autocmd("WinLeave", {
	pattern = { "draftpaper.txt", "_temp_script.*" },
	callback = function()
		vim.cmd.write()
	end,
})

-- This will run if the current file is in a "Project"
if project_root then
	local create_file = function(filename, dcontent)
		local content = dcontent:gsub("%s+\n", "\n"):gsub("%s+$", "")

		local filepath = project_root .. "/" .. filename
		local is_exists = vim.fn.findfile(filepath, ".;") ~= ""

		if not is_exists then
			if vim.fn.filereadable(filepath) == 0 then
				local f = io.open(filepath, "w")
				if f then
					f:write(content)
					f:close()
					vim.notify(filename .. " created automatically", "info")
				else
					vim.notify("Failed to create " .. filename, "error")
				end
			end
		end
	end

	-- auto create config files for formatter and git
	vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
		callback = function(ev)
			local ft = vim.bo[ev.buf].filetype

			local default_gitignore = [[
# SpectorVim files
*~
Session.vim
tagfiles
tags
.clangd
.editorconfig
.r00t_here

# Compiled intermediate files and dirs
.dirstamp
.deps
Makefile
config.scan
config.status
all-includes.txt

# Prerequisites
*.d

# Compiled Object files
*.slo
*.lo
*.o
*.obj

# Precompiled Headers
*.gch
*.pch

# Compiled Dynamic libraries
*.so
*.dylib
*.dll

# Fortran module files
*.mod
*.smod

# Compiled Static libraries
*.lai
*.la
*.a
*.lib

# Executables
*.exe
*.out
*.app

# Other files and dirs
temp
bin
*.log
*.cache
.env

        ]]
			create_file(".gitignore", default_gitignore)

			if ft == "asm" then
				local default_toml = [[

[default_config]
# Configure documentation available for features like hover and completions
assembler = "fasm"
instruction_set = "x86/x86-64"

[opts]
# The `compiler` field is the name of a compiler/assembler on your path
# (or the absolute path to the file) that is used to build your source files
# This program will be used to generate diagnostics
compiler = "gcc" # need "cc" as the first argument in `compile_flags.txt`
diagnostics = true
default_diagnostics = true

        ]]

				create_file(".asm-lsp.toml", default_toml)
			elseif (ft == "c" or ft == "cpp") and vim.g.clangd == 1 then
				local clang_format = [[
---
Language:        Cpp
# BasedOnStyle:  Google
AccessModifierOffset: -1
AlignAfterOpenBracket: Align
AlignArrayOfStructures: None
AlignConsecutiveMacros: None
AlignConsecutiveAssignments: None
AlignConsecutiveBitFields: None
AlignConsecutiveDeclarations: None
AlignEscapedNewlines: Left
AlignOperands:   Align
AlignTrailingComments: true
AllowAllArgumentsOnNextLine: true
AllowAllParametersOfDeclarationOnNextLine: true
AllowShortEnumsOnASingleLine: true
AllowShortBlocksOnASingleLine: Never
AllowShortCaseLabelsOnASingleLine: false
AllowShortFunctionsOnASingleLine: All
AllowShortLambdasOnASingleLine: All
AllowShortIfStatementsOnASingleLine: WithoutElse
AllowShortLoopsOnASingleLine: true
AlwaysBreakAfterDefinitionReturnType: None
AlwaysBreakAfterReturnType: None
AlwaysBreakBeforeMultilineStrings: true
AlwaysBreakTemplateDeclarations: Yes
AttributeMacros:
  - __capability
BinPackArguments: true
BinPackParameters: true
BraceWrapping:
  AfterCaseLabel:  false
  AfterClass:      false
  AfterControlStatement: Never
  AfterEnum:       false
  AfterFunction:   false
  AfterNamespace:  false
  AfterObjCDeclaration: false
  AfterStruct:     false
  AfterUnion:      false
  AfterExternBlock: false
  BeforeCatch:     false
  BeforeElse:      false
  BeforeLambdaBody: false
  BeforeWhile:     false
  IndentBraces:    false
  SplitEmptyFunction: true
  SplitEmptyRecord: true
  SplitEmptyNamespace: true
BreakBeforeBinaryOperators: None
BreakBeforeConceptDeclarations: true
BreakBeforeBraces: Attach
BreakBeforeInheritanceComma: false
BreakInheritanceList: BeforeColon
BreakBeforeTernaryOperators: true
BreakConstructorInitializersBeforeComma: false
BreakConstructorInitializers: BeforeColon
BreakAfterJavaFieldAnnotations: false
BreakStringLiterals: true
ColumnLimit:     80
CommentPragmas:  '^ IWYU pragma:'
QualifierAlignment: Leave
CompactNamespaces: false
ConstructorInitializerIndentWidth: 4
ContinuationIndentWidth: 4
Cpp11BracedListStyle: true
DeriveLineEnding: true
DerivePointerAlignment: true
DisableFormat:   false
EmptyLineAfterAccessModifier: Never
EmptyLineBeforeAccessModifier: LogicalBlock
ExperimentalAutoDetectBinPacking: false
PackConstructorInitializers: NextLine
BasedOnStyle:    ''
ConstructorInitializerAllOnOneLineOrOnePerLine: false
AllowAllConstructorInitializersOnNextLine: true
FixNamespaceComments: true
ForEachMacros:
  - foreach
  - Q_FOREACH
  - BOOST_FOREACH
IfMacros:
  - KJ_IF_MAYBE
IncludeBlocks:   Regroup
IncludeCategories:
  - Regex:           '^<ext/.*\.h>'
    Priority:        2
    SortPriority:    0
    CaseSensitive:   false
  - Regex:           '^<.*\.h>'
    Priority:        1
    SortPriority:    0
    CaseSensitive:   false
  - Regex:           '^<.*'
    Priority:        2
    SortPriority:    0
    CaseSensitive:   false
  - Regex:           '.*'
    Priority:        3
    SortPriority:    0
    CaseSensitive:   false
IncludeIsMainRegex: '([-_](test|unittest))?$'
IncludeIsMainSourceRegex: ''
IndentAccessModifiers: false
IndentCaseLabels: true
IndentCaseBlocks: false
IndentGotoLabels: true
IndentPPDirectives: None
IndentExternBlock: AfterExternBlock
IndentRequires:  false
IndentWidth:     2
IndentWrappedFunctionNames: false
InsertTrailingCommas: None
JavaScriptQuotes: Leave
JavaScriptWrapImports: true
KeepEmptyLinesAtTheStartOfBlocks: false
LambdaBodyIndentation: Signature
MacroBlockBegin: ''
MacroBlockEnd:   ''
MaxEmptyLinesToKeep: 1
NamespaceIndentation: None
ObjCBinPackProtocolList: Never
ObjCBlockIndentWidth: 2
ObjCBreakBeforeNestedBlockParam: true
ObjCSpaceAfterProperty: false
ObjCSpaceBeforeProtocolList: true
PenaltyBreakAssignment: 2
PenaltyBreakBeforeFirstCallParameter: 1
PenaltyBreakComment: 300
PenaltyBreakFirstLessLess: 120
PenaltyBreakOpenParenthesis: 0
PenaltyBreakString: 1000
PenaltyBreakTemplateDeclaration: 10
PenaltyExcessCharacter: 1000000
PenaltyReturnTypeOnItsOwnLine: 200
PenaltyIndentedWhitespace: 0
PointerAlignment: Left
PPIndentWidth:   -1
RawStringFormats:
  - Language:        Cpp
    Delimiters:
      - cc
      - CC
      - cpp
      - Cpp
      - CPP
      - 'c++'
      - 'C++'
    CanonicalDelimiter: ''
    BasedOnStyle:    google
  - Language:        TextProto
    Delimiters:
      - pb
      - PB
      - proto
      - PROTO
    EnclosingFunctions:
      - EqualsProto
      - EquivToProto
      - PARSE_PARTIAL_TEXT_PROTO
      - PARSE_TEST_PROTO
      - PARSE_TEXT_PROTO
      - ParseTextOrDie
      - ParseTextProtoOrDie
      - ParseTestProto
      - ParsePartialTestProto
    CanonicalDelimiter: pb
    BasedOnStyle:    google
ReferenceAlignment: Pointer
ReflowComments:  true
RemoveBracesLLVM: false
SeparateDefinitionBlocks: Leave
ShortNamespaceLines: 1
SortIncludes:    CaseSensitive
SortJavaStaticImport: Before
SortUsingDeclarations: true
SpaceAfterCStyleCast: false
SpaceAfterLogicalNot: false
SpaceAfterTemplateKeyword: true
SpaceBeforeAssignmentOperators: true
SpaceBeforeCaseColon: false
SpaceBeforeCpp11BracedList: false
SpaceBeforeCtorInitializerColon: true
SpaceBeforeInheritanceColon: true
SpaceBeforeParens: ControlStatements
SpaceBeforeParensOptions:
  AfterControlStatements: true
  AfterForeachMacros: true
  AfterFunctionDefinitionName: false
  AfterFunctionDeclarationName: false
  AfterIfMacros:   true
  AfterOverloadedOperator: false
  BeforeNonEmptyParentheses: false
SpaceAroundPointerQualifiers: Default
SpaceBeforeRangeBasedForLoopColon: true
SpaceInEmptyBlock: false
SpaceInEmptyParentheses: false
SpacesBeforeTrailingComments: 2
SpacesInAngles:  Never
SpacesInConditionalStatement: false
SpacesInContainerLiterals: true
SpacesInCStyleCastParentheses: false
SpacesInLineCommentPrefix:
  Minimum:         1
  Maximum:         -1
SpacesInParentheses: false
SpacesInSquareBrackets: false
SpaceBeforeSquareBrackets: false
BitFieldColonSpacing: Both
Standard:        Auto
StatementAttributeLikeMacros:
  - Q_EMIT
StatementMacros:
  - Q_UNUSED
  - QT_REQUIRE_VERSION
TabWidth:        8
UseCRLF:         false
UseTab:          Never
WhitespaceSensitiveMacros:
  - STRINGIZE
  - PP_STRINGIZE
  - BOOST_PP_STRINGIZE
  - NS_SWIFT_NAME
  - CF_SWIFT_NAME
...

        ]]
				create_file(".clang_format", clang_format)

				if CheckLspHealth("clangd") then
					local clangd
					if vim.fn.has("win32") == 1 then
						clangd = [[
CompileFlags:
    Add:
      - --target=x86_64-pc-windows-msvc
      - -I./include
      - -Wall


        ]]
					else
						clangd = [[
CompileFlags:
    Add: 
      - -I./include
      - -std=c23
      - -Wall

        ]]
					end
					create_file(".clangd", clangd)
				end

				if vim.fn.has("win32") == 1 then
					local compile_flags = [[
-isystem
C:/Program Files/Microsoft Visual Studio/2022/Community/VC/Tools/MSVC/14.29.30133/include
-isystem
C:/Program Files (x86)/Windows Kits/10/Include/10.0.26100.0/ucrt
-isystem
C:/Program Files (x86)/Windows Kits/10/Include/10.0.26100.0/shared
-isystem
C:/Program Files (x86)/Windows Kits/10/Include/10.0.26100.0/um

      ]]
					create_file("compile_flags.txt", compile_flags)
				end
			elseif ft == "lua" then
				local stylua_toml = [[
syntax = "LuaJIT"
        ]]
				create_file("stylua.toml", stylua_toml)
			else
				local default_editorconfig = [[
root = true

[*]
indent_style = space
indent_size = 4
tab_width = 4
end_of_line = lf
insert_final_newline = true
        ]]
				create_file(".editorconfig", default_editorconfig)
			end
		end,
	})

	-- auto :Obsession
	vim.api.nvim_create_autocmd({ "VimLeave" }, { command = "Obsession" })
	-- vim.api.nvim_create_autocmd("VimEnter", {
	-- 	callback = function()
	-- 		local filepath = project_root .. "/Session.vim"
	-- 		local is_exists = vim.fn.findfile(filepath, ".;") ~= ""
	-- 		if not is_exists then
	-- 			vim.cmd("Obsession")
	-- 		end
	-- 	end,
	-- })
end

-- Auto set: Tab or 4 space
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = { "Makefile", "Makefile.*" },
	callback = function()
		vim.cmd("set noexpandtab")
		vim.cmd("set list")
	end,
})
vim.api.nvim_create_autocmd("WinLeave", {
	pattern = { "Makefile", "Makefile.*" },
	callback = function()
		vim.cmd("set expandtab")
		vim.cmd("set nolist")
	end,
})

-- Suggestion: Use `:set syntax?` instead of nvim-treesitter for specific files
--
-- set nvim-treesitter parsers for specific files
-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
--   pattern = { "configure.ac", "configure.in" },
--   callback = function(args)
--     vim.treesitter.start(args.buf, "editorconfig")
--   end,
-- })

-- shared registers
vim.api.nvim_create_augroup("SHADA", { clear = true })
-- vim.api.nvim_create_autocmd({ "CursorHold", "TextYankPost", "FocusGained", "FocusLost" }, {

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	group = "SHADA",
	callback = function()
		-- :wshada -> :rshada
		-- This may be delayed for unknown reasons. So we save an additional backup in @r.
		vim.cmd('let @r = @"')
		vim.cmd("wshada")
	end,
})

-- Hook paste for Shada
-- vim.paste = (function(overridden)
-- 	return function(lines, phase)
-- 		print("SpecterVim: hook paste")
-- 		vim.cmd("rshada")
-- 		return overridden(lines, phase)
-- 	end
-- end)(vim.paste)

-- Hook p for Shada
if vim.g.specter_debug == 1 then
	vim.keymap.set("n", "p", function()
		print("SpecterVim: hook p")
		vim.cmd("rshada")
		return "p"
	end, { expr = true })
else
	vim.keymap.set("n", "p", function()
		vim.cmd("rshada")
		return "p"
	end, { expr = true })
end

-- Use quickfix for ctags
vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.keymap.set("n", "<CR>", function()
			vim.cmd([[

let qf = getqflist({'idx': 0, 'items': 1})
let top_item = qf.items[0]
if top_item.module == "ctags"
  " execute "normal! \<C-w>\<CR>"
  " execute "normal! \<C-w>p"
  execute ".cc"
  " sleep 100m
  let qf = getqflist({'idx': 0, 'items': 1})
  let item = qf.items[qf.idx - 1]
  let cmd = item.user_data.cmd

  " 从Ctags到Vim search，可能有转义问题
  " 以下转义取自Neovim: src/nvim/ex_getln.c
  " # define PATH_ESC_CHARS " \t\n*?[{`$\\%#'\"|!<"
  " # define SHELL_ESC_CHARS " \t\n*?[{`$\\%#'\"|!<>();&"
  " # define BUFFER_ESC_CHARS " \t\n*?[`$\\%#'\"|!<"

  let cmd = escape(cmd, "\t\n*[]`#!")
  " let cmd = substitute(cmd, '\\\\', '\\', 'g')
  " let cmd = substitute(cmd, '\[', '\\\[', 'g')
  " let cmd = substitute(cmd, '\]', '\\\]', 'g')

  echo "Search:" .. cmd
  execute cmd
  " call search(pattern)
else
  execute ".cc"
endif

      ]])
		end, { buffer = true })
	end,
})
