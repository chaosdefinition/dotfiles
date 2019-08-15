" Chaos's color scheme for Vim.
" Modified from ron.vim by Ron Aaron <ron@ronware.org>.

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "chaos"

hi Normal         guifg=Cyan          guibg=Black
hi NonText        guifg=Yellow        guibg=#303030
hi Comment        guifg=Green
hi Constant       guifg=Cyan          gui=bold
hi Identifier     guifg=Cyan          gui=NONE
hi Statement      guifg=LightBlue     gui=NONE
hi Preproc        guifg=Pink2
hi Type           guifg=SeaGreen      gui=bold
hi Special        guifg=Yellow
hi ErrorMsg       guifg=Black         guibg=Red
hi WarningMsg     guifg=Black         guibg=Green
hi Error          guibg=Red
hi Todo           guifg=Black         guibg=Orange
hi Cursor         guibg=#60a060       guifg=#00ff00
hi Search         guibg=DarkGrey      guifg=Black         gui=bold
hi IncSearch      gui=NONE            guibg=SteelBlue
hi LineNr         guifg=DarkGrey
hi CursorLineNr   cterm=reverse       ctermfg=DarkYellow  gui=reverse     guifg=DarkYellow
hi Title          guifg=DarkGrey
hi ShowMarksHL    ctermfg=Cyan        ctermbg=LightBlue   cterm=bold      guifg=Yellow guibg=Black gui=bold
hi StatusLineNC   gui=NONE            guifg=Lightblue     guibg=DarkBlue
hi StatusLine     gui=bold            guifg=Cyan          guibg=Blue
hi Label          ctermfg=Yellow      guifg=Gold2
hi Operator       ctermfg=Yellow      guifg=Orange
"hi clear Visual
"hi Visual         term=reverse        cterm=reverse       gui=reverse
hi DiffChange     guibg=DarkGreen
hi DiffText       guibg=OliveDrab
hi DiffAdd        guibg=SlateBlue
hi DiffDelete     guibg=Coral
hi Folded         guibg=Grey30
hi FoldColumn     guibg=Grey30        guifg=White
hi cIf0           guifg=Grey
hi diffOnly       guifg=Red           gui=bold
hi WhitespaceEOL  ctermbg=DarkYellow  guibg=DarkYellow
"hi LongLine       ctermbg=DarkYellow  guibg=DarkYellow
