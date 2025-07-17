local hi = vim.api.nvim_set_hl

vim.cmd "highlight clear"
vim.cmd "syntax reset"

-- vim.g.colors_name = "xres2"

hi(0, "Normal",       { ctermfg = 07 })
hi(0, "Debug",        { ctermfg = 01 })
hi(0, "Directory",    { ctermfg = 04 })
hi(0, "Error",        { ctermfg = 00, ctermbg = 01 })
hi(0, "ErrorMsg",     { ctermfg = 01, ctermbg = 00 })
hi(0, "Exception",    { ctermfg = 01 })
hi(0, "FoldColumn",   { ctermfg = 06, ctermbg = 10 })
hi(0, "Folded",       { ctermfg = 08, ctermbg = 10 })
hi(0, "IncSearch",    { ctermfg = 10, ctermbg = 10 })
hi(0, "Italic",       { })
hi(0, "Macro",        { ctermfg=01 })
hi(0, "MatchParen",   { ctermbg=08 })
hi(0, "ModeMsg",      { ctermfg=02 })
hi(0, "MoreMsg",      { ctermfg=02 })
hi(0, "Question",     { ctermfg=04 })
hi(0, "Search",       { ctermfg=08, ctermbg=03 })
hi(0, "Substitute",   { ctermfg=08, ctermbg=03 })
hi(0, "SpecialKey",   { ctermfg=08 })
hi(0, "TooLong",      { ctermfg=01 })
hi(0, "Underlined",   { ctermfg=01 })
hi(0, "Visual",       { ctermbg=08 })
hi(0, "VisualNOS",    { ctermfg=01 })
hi(0, "WarningMsg",   { ctermfg=01 })
hi(0, "WildMenu",     { ctermfg=01 })
hi(0, "Title",        { ctermfg=04 })
hi(0, "Conceal",      { ctermfg=04, ctermbg=00 })
hi(0, "Cursor",       { ctermfg=00, ctermbg=07 })
hi(0, "NonText",      { ctermfg=08 })
hi(0, "LineNr",       { ctermfg=08, ctermbg=10 })
hi(0, "SignColumn",   { ctermfg=08, ctermbg=00 })
hi(0, "StatusLine",   { ctermfg=04, ctermbg=08 })
hi(0, "StatusLineNC", { ctermfg=07, ctermbg=08 })
hi(0, "VertSplit",    { ctermfg=08, ctermbg=01 })
hi(0, "ColorColumn",  { ctermbg=10 })
hi(0, "CursorColumn", { ctermbg=10 })
hi(0, "CursorLine",   { ctermbg=10 })
hi(0, "CursorLineNr", { ctermfg=12, ctermbg=10 })
hi(0, "QuickFixLine", { ctermbg=10 })
hi(0, "PMenu",        { ctermfg=07, ctermbg=08 })
hi(0, "PMenuSel",     { ctermfg=04, ctermbg=08 })
hi(0, "TabLine",      { ctermfg=07, ctermbg=00 })
hi(0, "TabLineFill",  { ctermfg=07 })
hi(0, "TabLineSel",   { ctermfg=04 })

-- Standard syntax highlighting
hi(0, "PodData",      { ctermfg=09 })
hi(0, "Boolean",      { link = "PodData" })
hi(0, "Character",    { link = "PodData" })
hi(0, "Number",       { link = "PodData" })
hi(0, "Float",        { link = "PodData" })

hi(0, "Attribute",    { ctermfg=09 })
hi(0, "Comment",      { ctermfg=15 })
hi(0, "Conditional",  { ctermfg=05 })
hi(0, "Constant",     { ctermfg=09 })
hi(0, "Define",       { ctermfg=05 })
hi(0, "Delimiter",    { ctermfg=07 })
hi(0, "Field",        { ctermfg=09 })
hi(0, "Function",     { ctermfg=04 })
hi(0, "Identifier",   { ctermfg=01 })
hi(0, "Include",      { ctermfg=04 })
hi(0, "Keyword",      { ctermfg=05 })
hi(0, "Label",        { ctermfg=03 })
hi(0, "Namespace",    { ctermfg=06 })
hi(0, "Operator",     { ctermfg=06 })
hi(0, "PreProc",      { ctermfg=03 })
hi(0, "PreCondit",    { ctermfg=05 })
hi(0, "Repeat",       { ctermfg=05 })
hi(0, "Special",      { ctermfg=06 })
hi(0, "SpecialChar",  { ctermfg=14 })
hi(0, "Statement",    { ctermfg=01 })
hi(0, "StorageClass", { ctermfg=03 })
hi(0, "String",       { ctermfg=02 })
hi(0, "Structure",    { ctermfg=05 })
hi(0, "Tag",          { ctermfg=03 })
hi(0, "Todo",         { ctermfg=07, ctermbg=08 })
hi(0, "Type",         { ctermfg=03 })
hi(0, "Typedef",      { ctermfg=03 })

-- LSP highlighting
hi(0, "LspDiagnostic",           { ctermfg=15, ctermbg=08 })
hi(0, "LspDiagnosticsUnderline", {             ctermbg=08 })

hi(0, "LspDiagnosticsError",                { link = "LspDiagnostic" })
hi(0, "LspDiagnosticsError",                { link = "LspDiagnostic" })
hi(0, "LspDiagnosticsWarning",              { link = "LspDiagnostic" })
hi(0, "LspDiagnosticsHint",                 { link = "LspDiagnostic" })
hi(0, "LspDiagnosticsInformation",          { link = "LspDiagnostic" })
hi(0, "LspDiagnosticsUnderlineError",       { link = "LspDiagnosticsUnderline" })
hi(0, "LspDiagnosticsUnderlineWarning",     { link = "LspDiagnosticsUnderline" })
hi(0, "LspDiagnosticsUnderlineHint",        { link = "LspDiagnosticsUnderline" })
hi(0, "LspDiagnosticsUnderlineInformation", { link = "LspDiagnosticsUnderline" })
hi(0, "LspDiagnosticsUnderline",            { link = "LspDiagnosticsUnderline" })

hi(0, "LspDiagnosticsError", { ctermfg=01 })

hi(0, "@attribute",         { link = "Attribute" })
hi(0, "@boolean",           { link = "Boolean" })
hi(0, "@character",         { link = "Character" })
hi(0, "@character.special", { link = "SpecialChar" })   -- TODO
hi(0, "@comment",           { link = "Comment" })       -- TODO
hi(0, "@conditional",       { link = "Conditional" })
hi(0, "@conditional",       { link = "Conditional" })   -- TODO
hi(0, "@constant",          { link = "Constant" })
hi(0, "@constant.builtin",  { link = "Constant" })
hi(0, "@constant.macro",    { link = "Constant" })
hi(0, "@constructor",       { link = "Normal" })        -- TODO
hi(0, "@debug",             { link = "Debug" })         -- TODO
hi(0, "@define",            { link = "Define" })        -- TODO
hi(0, "@exception",         { link = "Identifier" })
hi(0, "@field",             { link = "Field" })
hi(0, "@float",             { link = "Float" })
hi(0, "@function",          { link = "Function" })
hi(0, "@function.builtin",  { link = "Special" })       -- TODO
hi(0, "@function.macro",    { link = "Macro" })         -- TODO
hi(0, "@include",           { link = "Include" })
hi(0, "@keyword",           { link = "Keyword" })
hi(0, "@label",             { link = "Normal" })        -- TODO
hi(0, "@macro",             { link = "Macro" })
hi(0, "@method",            { link = "Function" })
hi(0, "@namespace",         { link = "Namespace" })
hi(0, "@number",            { link = "Number" })
hi(0, "@operator",          { link = "Operator" })
hi(0, "@parameter",         { link = "Normal" })
hi(0, "@preproc",           { link = "PreProc" })       -- TODO
hi(0, "@property",          { link = "Field" })         -- TODO: better link target
hi(0, "@punctuation",       { link = "Normal" })
hi(0, "@repeat",            { link = "Repeat" })
hi(0, "@storageclass",      { link = "StorageClass" })  -- TODO
hi(0, "@string",            { link = "String" })
hi(0, "@string.escape",     { link = "SpecialChar" })   -- TODO
hi(0, "@string.special",    { link = "SpecialChar" })   -- TODO
hi(0, "@structure",         { link = "Normal" })        -- TODO
hi(0, "@tag",               { link = "Tag" })           -- TODO
hi(0, "@text.literal",      { link = "Comment" })       -- TODO
hi(0, "@text.reference",    { link = "Identifier" })    -- TODO
hi(0, "@text.title",        { link = "Title" })         -- TODO
hi(0, "@text.todo",         { link = "Todo" })          -- TODO
hi(0, "@text.underline",    { link = "Underlined" })    -- TODO
hi(0, "@text.uri",          { link = "Underlined" })    -- TODO
hi(0, "@type",              { link = "Type" })
hi(0, "@type.qualifier",    { link = "Keyword" })       -- TODO
hi(0, "@type.definition",   { link = "Typedef" })       -- TODO
hi(0, "@variable",          { link = "Normal" })
hi(0, "@variable.builtin",  { link = "Field" })


-- CPP highlighting
hi(0, "cppCast",                 { ctermfg=06 })
hi(0, "@keyword.import.cpp",     { link = "Include" })
hi(0, "@module.cpp",             { link = "Namespace" })
hi(0, "@lsp.type.namespace.cpp", { link = "Namespace" })
hi(0, "@type.builtin.cpp",       { link = "Type" })
hi(0, "@keyword.directive.cpp",  { link = "Macro" })


-- Diff highlighting
hi(0, "DiffAdd",     { ctermfg=02, ctermbg=10 })
hi(0, "DiffChange",  { ctermfg=08, ctermbg=10 })
hi(0, "DiffDelete",  { ctermfg=01, ctermbg=10 })
hi(0, "DiffText",    { ctermfg=04, ctermbg=10 })
hi(0, "DiffAdded",   { ctermfg=02, ctermbg=00 })
hi(0, "DiffFile",    { ctermfg=01, ctermbg=00 })
hi(0, "DiffNewFile", { ctermfg=02, ctermbg=00 })
hi(0, "DiffLine",    { ctermfg=04, ctermbg=00 })
hi(0, "DiffRemoved", { ctermfg=01, ctermbg=00 })


-- Git highlighting
hi(0, "gitcommitOverflow",      { ctermfg=01 })
hi(0, "gitcommitSummary",       { ctermfg=02 })
hi(0, "gitcommitComment",       { ctermfg=08 })
hi(0, "gitcommitUntracked",     { ctermfg=08 })
hi(0, "gitcommitDiscarded",     { ctermfg=08 })
hi(0, "gitcommitSelected",      { ctermfg=08 })
hi(0, "gitcommitHeader",        { ctermfg=05 })
hi(0, "gitcommitSelectedType",  { ctermfg=04 })
hi(0, "gitcommitUnmergedType",  { ctermfg=04 })
hi(0, "gitcommitDiscardedType", { ctermfg=04 })
hi(0, "gitcommitBranch",        { ctermfg=09,            cterm=bold })
hi(0, "gitcommitUntrackedFile", { ctermfg=03 })
hi(0, "gitcommitUnmergedFile",  { ctermfg=01,            cterm=bold })
hi(0, "gitcommitDiscardedFile", { ctermfg=01,            cterm=bold })
hi(0, "gitcommitSelectedFile",  { ctermfg=02,            cterm=bold })


-- GitGutter
hi(0, "GitGutterAdd",          { ctermfg=02, ctermbg=10 })
hi(0, "GitGutterChange",       { ctermfg=04, ctermbg=10 })
hi(0, "GitGutterDelete",       { ctermfg=01, ctermbg=10 })
hi(0, "GitGutterChangeDelete", { ctermfg=05, ctermbg=10 })


-- Markdown
hi(0, "markdownCode",             { ctermfg=02 })
hi(0, "markdownError",            { ctermfg=07, ctermbg=00 })
hi(0, "markdownCodeBlock",        { ctermfg=02 })
hi(0, "markdownHeadingDelimiter", { ctermfg=04 })


-- Python
hi(0, "pythonOperator",  { ctermfg=05 })
hi(0, "pythonRepeat",    { ctermfg=05 })
hi(0, "pythonInclude",   { ctermfg=05 })
hi(0, "pythonStatement", { ctermfg=05 })


-- Compe
hi(0, "CompeDocumentation",  { link = "NormalFloat" })
