" Theme setup
hi clear
syntax reset
let g:colors_name = "xres"

" Vim editor colors
hi Normal                     ctermfg=07 ctermbg=00
hi Debug                      ctermfg=01
hi Directory                  ctermfg=04
hi Error                      ctermfg=00 ctermbg=01
hi ErrorMsg                   ctermfg=01 ctermbg=00
hi Exception                  ctermfg=01
hi FoldColumn                 ctermfg=06 ctermbg=10
hi Folded                     ctermfg=08 ctermbg=10
hi IncSearch                  ctermfg=10 ctermbg=09 cterm=none
hi Italic                                           cterm=none
hi Macro                      ctermfg=01
hi MatchParen                            ctermbg=08
hi ModeMsg                    ctermfg=02
hi MoreMsg                    ctermfg=02
hi Question                   ctermfg=04
hi Search                     ctermfg=08 ctermbg=03
hi Substitute                 ctermfg=08 ctermbg=03 cterm=none
hi SpecialKey                 ctermfg=08
hi TooLong                    ctermfg=01
hi Underlined                 ctermfg=01
hi Visual                                ctermbg=08
hi VisualNOS                  ctermfg=01
hi WarningMsg                 ctermfg=01
hi WildMenu                   ctermfg=01
hi Title                      ctermfg=04            cterm=none
hi Conceal                    ctermfg=04 ctermbg=00
hi Cursor                     ctermfg=00 ctermbg=07
hi NonText                    ctermfg=08
hi LineNr                     ctermfg=08 ctermbg=10
hi SignColumn                 ctermfg=08 ctermbg=00
hi StatusLine                 ctermfg=04 ctermbg=08 cterm=none
hi StatusLineNC               ctermfg=07 ctermbg=08 cterm=none
hi VertSplit                  ctermfg=08 ctermbg=00 cterm=none
hi ColorColumn                           ctermbg=10 cterm=none
hi CursorColumn                          ctermbg=10 cterm=none
hi CursorLine                            ctermbg=10 cterm=none
hi CursorLineNr               ctermfg=12 ctermbg=10
hi QuickFixLine                          ctermbg=10 cterm=none
hi PMenu                      ctermfg=07 ctermbg=00 cterm=none
hi PMenuSel                   ctermfg=04 ctermbg=00
hi TabLine                    ctermfg=07 ctermbg=00 cterm=none
hi TabLineFill                ctermfg=07 ctermbg=00 cterm=none
hi TabLineSel                 ctermfg=04 ctermbg=00 cterm=none

" Standard syntax highlighting
hi PodData                    ctermfg=09
hi link Boolean   PodData
hi link Character PodData
hi link Number    PodData
hi link Float     PodData
hi String                     ctermfg=02
hi Comment                    ctermfg=15
hi Conditional                ctermfg=05
hi Constant                   ctermfg=09
hi Define                     ctermfg=05            cterm=none
hi Delimiter                  ctermfg=14
hi Function                   ctermfg=04
hi Identifier                 ctermfg=01            cterm=none
hi Include                    ctermfg=04
hi Keyword                    ctermfg=05
hi Label                      ctermfg=03
hi Operator                   ctermfg=06            cterm=none
hi PreProc                    ctermfg=03
hi PreCondit                  ctermfg=05
hi Repeat                     ctermfg=05
hi Special                    ctermfg=06
hi SpecialChar                ctermfg=14
hi Statement                  ctermfg=01
hi StorageClass               ctermfg=03
hi Structure                  ctermfg=05
hi Tag                        ctermfg=03
hi Todo                       ctermfg=00 ctermbg=08
hi Type                       ctermfg=03            cterm=none
hi Typedef                    ctermfg=03

" LSP highlighting
hi LspDiagnostic              ctermfg=15 ctermbg=08
hi LspDiagnosticsUnderline               ctermbg=08

hi link LspDiagnosticsError                LspDiagnostic
hi link LspDiagnosticsWarning              LspDiagnostic
hi link LspDiagnosticsHint                 LspDiagnostic
hi link LspDiagnosticsInformation          LspDiagnostic
hi link LspDiagnosticsUnderlineError       LspDiagnosticsUnderline
hi link LspDiagnosticsUnderlineWarning     LspDiagnosticsUnderline
hi link LspDiagnosticsUnderlineHint        LspDiagnosticsUnderline
hi link LspDiagnosticsUnderlineInformation LspDiagnosticsUnderline
hi link LspDiagnosticsUnderline            LspDiagnosticsUnderline

hi LspDiagnosticsError        ctermfg=01

" CPP highlighting
hi cppCast                    ctermfg=06

" Diff highlighting
hi DiffAdd                    ctermfg=02 ctermbg=10
hi DiffChange                 ctermfg=08 ctermbg=10
hi DiffDelete                 ctermfg=01 ctermbg=10
hi DiffText                   ctermfg=04 ctermbg=10
hi DiffAdded                  ctermfg=02 ctermbg=00
hi DiffFile                   ctermfg=01 ctermbg=00
hi DiffNewFile                ctermfg=02 ctermbg=00
hi DiffLine                   ctermfg=04 ctermbg=00
hi DiffRemoved                ctermfg=01 ctermbg=00

" Git highlighting
hi gitcommitOverflow          ctermfg=01
hi gitcommitSummary           ctermfg=02
hi gitcommitComment           ctermfg=08
hi gitcommitUntracked         ctermfg=08
hi gitcommitDiscarded         ctermfg=08
hi gitcommitSelected          ctermfg=08
hi gitcommitHeader            ctermfg=05
hi gitcommitSelectedType      ctermfg=04
hi gitcommitUnmergedType      ctermfg=04
hi gitcommitDiscardedType     ctermfg=04
hi gitcommitBranch            ctermfg=09            cterm=bold
hi gitcommitUntrackedFile     ctermfg=03
hi gitcommitUnmergedFile      ctermfg=01            cterm=bold
hi gitcommitDiscardedFile     ctermfg=01            cterm=bold
hi gitcommitSelectedFile      ctermfg=02            cterm=bold

" GitGutter highlighting
hi GitGutterAdd               ctermfg=02 ctermbg=10
hi GitGutterChange            ctermfg=04 ctermbg=10
hi GitGutterDelete            ctermfg=01 ctermbg=10
hi GitGutterChangeDelete      ctermfg=05 ctermbg=10

" Markdown highlighting
hi markdownCode               ctermfg=02
hi markdownError              ctermfg=07 ctermbg=00
hi markdownCodeBlock          ctermfg=02
hi markdownHeadingDelimiter   ctermfg=04

" Python highlighting
hi pythonOperator             ctermfg=05
hi pythonRepeat               ctermfg=05
hi pythonInclude              ctermfg=05
hi pythonStatement            ctermfg=05

