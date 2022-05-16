" Chaos's vimrc
"
" Modified from /etc/vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Bail out if something that ran earlier, e.g. a system wide vimrc, does not
" want Vim to use these default values.
if exists('skip_defaults_vim')
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

set history=200     " keep 200 lines of command line history
set ruler           " show the cursor position all the time
set showcmd         " display incomplete commands
set wildmenu        " display completion matches in a status line
set number          " display line number
set colorcolumn=80  " display ruler at 80
set nowrap          " do not wrap lines
set hlsearch        " highlight search results
set visualbell      " disable beeping
set t_vb=           " disable visual bell
set redrawtime=5000 " 5-second redraw timeout

" Manually set up color scheme
colorscheme chaos

" Highlight current line
set cursorline

set ttimeout        " time out for key codes
set ttimeoutlen=100 " wait up to 100ms after Esc for special key

" Default tab settings
set tabstop=8     " set tab size to 8
set shiftwidth=8  " set shift width to be the same as tab size
set softtabstop=0 " use tabs and appropriate number of spaces to align
set noexpandtab   " do not use space to replace tab

" Show @@@ in the last line if it is truncated.
if v:version > 800
  set display=truncate
endif

" Show a few lines of context around the cursor.  Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set scrolloff=5

" Do incremental searching when it's possible to timeout.
if has('reltime')
  set incsearch
endif

" Do not recognize octal numbers for Ctrl-A and Ctrl-X, most users find it
" confusing.
set nrformats-=octal

set spelllang=en
set spellfile="~/.vim/spell/en.utf-8.add"

" Update spelling
for d in split(globpath('~/.vim/spell', '*.add'))
  if filereadable(d) && (!filereadable(d . '.spl') || getftime(d) > getftime(d . '.spl'))
    exec 'mkspell! ' . fnameescape(d)
  endif
endfor

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries.
if has('win32')
  set guioptions-=t
endif

" Don't use Ex mode, use Q for formatting.
" Revert with ":unmap Q".
map Q gq

" Toggle spell check.
map <F6> :setlocal spell! spell?<CR>

" Toggle NERDTree
map <C-O> :NERDTreeToggle<CR>

" New tab
map <C-N> :tabedit<CR>

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Revert with ":iunmap <C-U>".
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine.  By enabling it you
" can position the cursor, Visually select and scroll with the mouse.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on when the terminal has colors or when using the
" GUI (which always has colors).
if &t_Co > 2 || has("gui_running")
  " Revert with ":syntax off".
  syntax on

  " I like highlighting strings inside C comments.
  " Revert with ":unlet c_comment_strings".
  let c_comment_strings=1
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  " Revert with ":filetype off".
  filetype plugin indent on

  " Put these in an autocmd group, so that you can revert them with:
  " ":augroup vimStartup | au! | augroup END"
  augroup vimStartup
    au!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
          \ if line("'\"") >= 1 && line("'\"") <= line("$") |
          \   exe "normal! g`\"" |
          \ endif

  augroup END

  " Highlight trailing whitespace.
  highlight WhitespaceEOL ctermbg=DarkYellow guibg=DarkYellow
  autocmd BufWinEnter * match WhitespaceEOL /\s\+$/
  autocmd InsertEnter * match WhitespaceEOL /\s\+$/
  autocmd InsertLeave * match WhitespaceEOL /\s\+$/

  " Use c highlighting for .h files by default (instead of cpp)
  autocmd BufNewFile,BufRead *.h setfiletype c

  " Following file types use tab size 2 and use spaces to replace tabs
  autocmd Filetype bib setlocal tabstop=2 shiftwidth=2 expandtab
  autocmd Filetype cpp setlocal tabstop=2 shiftwidth=2 expandtab
  autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab
  autocmd Filetype llvm setlocal tabstop=2 shiftwidth=2 expandtab
  autocmd Filetype muttrc setlocal tabstop=2 shiftwidth=2 expandtab
  autocmd Filetype ruby setlocal tabstop=2 shiftwidth=2 expandtab
  autocmd Filetype tex setlocal tabstop=2 shiftwidth=2 expandtab
  autocmd Filetype vim setlocal tabstop=2 shiftwidth=2 expandtab
  autocmd Filetype yaml setlocal tabstop=2 shiftwidth=2 expandtab

  " Following file types use tab size 4 and use spaces to replace tabs
  autocmd Filetype css setlocal tabstop=4 shiftwidth=4 expandtab
  autocmd Filetype java setlocal tabstop=4 shiftwidth=4 expandtab
  autocmd Filetype javascript setlocal tabstop=4 shiftwidth=4 expandtab
  autocmd Filetype python setlocal tabstop=4 shiftwidth=4 expandtab
  autocmd Filetype sh setlocal tabstop=4 shiftwidth=4 expandtab

  " Following file types use tab size 8 and keep tabs
  autocmd Filetype asm setlocal tabstop=8 shiftwidth=8 noexpandtab
  autocmd Filetype c setlocal tabstop=8 shiftwidth=8 noexpandtab
  autocmd Filetype gitcommit setlocal tabstop=8 shiftwidth=8 noexpandtab
  autocmd Filetype gitconfig setlocal tabstop=8 shiftwidth=8 noexpandtab

  " Following file types automatically wrap lines at 72 characters
  autocmd Filetype gitcommit setlocal textwidth=72 formatoptions=cqt
  autocmd Filetype mail setlocal textwidth=72 formatoptions=cqt

  " Don't show trailing whitespace on following file types
  autocmd Filetype mail highlight WhitespaceEOL ctermbg=NONE guibg=NONE

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If set (default), this may break plugins (but it's backward
  " compatible).
  set nolangremap
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle setup """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable(expand('~/.vim/.vimrc.bundles'))
  source ~/.vim/.vimrc.bundles
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Clipboard settings """""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('clipboard') && has('xterm_clipboard')
  set clipboard=unnamedplus
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Miscellaneous settings """""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tex_flavor = "latex"  " Default LaTeX
let NERDTreeShowHidden = 1  " Show hidden files in NERDTree

set directory=~/.vim/swap//

if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif
