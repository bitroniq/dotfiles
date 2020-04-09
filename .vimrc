" Based on:
" https://github.com/skwp/dotfiles
" https://github.com/souravchk/dotfiles/blob/master/vimrc

syntax on

set nocompatible
set backspace=indent,eol,start
set incsearch
set hlsearch
set number                      " Show line numbers
"set cursorline                  " Highlight the currently selected line
"set undolevels=1000             " Set undo amount to 1000
set ignorecase                  " Enable case insenstive search
set ruler                       " show current position at bottom
"set list                        " show invisible characters
"set mouse=a                     " try to use a mouse in the console (wimp!)
set showmatch                   " show matching brackets
set autoindent                  " set the cursor at same indent as line above
set smartindent                 " try to be smart about indenting (C-style)
set expandtab                   " expand <Tab>s with spaces; death to tabs!
set shiftwidth=4                " spaces for each step of (auto)indent
set softtabstop=4               " set virtual tab stop (compat for 8-wide tabs)
set tabstop=4                   " for proper display of files with tabs
set shiftround                  " always round indents to multiple of shiftwidth
set copyindent                  " use existing indents for new indents
set preserveindent              " save as much indent structure as possible
set encoding=utf-8
set ls=1                        " always show status line
set scrolloff=3                 " keep 3 lines when scrolling
set showcmd                     " display incomplete commands
set nobackup                    " do not keep backup files
"set paste                      " Paste mode - breaks autoindent
set smarttab
set smartcase
set term=screen-256color
"set term=xterm-256color
set colorcolumn=79              " Show vertical line to indicate too long lines

filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

"-------------- PLUGINS STARTS -----------------
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
"Plugin 'scrooloose/syntastic' "Syntax checking for vim (supports all langs)
                              "Can be replaced with ALE (Asynchronous Lint
                              "Engine)
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
Plugin 'majutsushi/tagbar'
Plugin 'ctrlpvim/ctrlp.vim' "fuzzy finder CTRL+P like in Sublime
Plugin 'vim-scripts/a.vim' "while editing foo.c execute :A to switch to foo.h
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive' "type :G<tab> to see git commands
Plugin 'Raimondi/delimitMate' "auto-completion for quotes, parens, brackets
Plugin 'christoomey/vim-tmux-navigator'
" - navigation btwn tmux panes and vim splits - ctrl hjkl (need to add 
"   snippet to .tmux.conf
Plugin 'jez/vim-c0' "syntax highlighting in c0
Plugin 'jez/vim-ispc' "syntax hihlighting for ISPC
Plugin 'kchmck/vim-coffee-script'
Plugin 'flazz/vim-colorschemes'
Plugin 'itchyny/calendar.vim'
Plugin 'puppetlabs/puppet-syntax-vim'
Plugin 'neoclide/coc.nvim' "Coc - Conquer of Completion - is an intellisense
                           "engine for vim8 & neovim
"Plugin 'ryanoasis/vim-devicons'
Plugin 'dense-analysis/ale' "ALE (Asynchronous Lint Engine) linting
                            "(syntax checking and semantic errors)
                            " :ALEToggle

Plugin 'Yggdroot/indentLine' "displaying thin vertical lines at each indentA
Plugin 'elzr/vim-json'

call vundle#end()
"-------------- PLUGINS END --------------------
filetype plugin indent on

"----- GENERAL SETTINGS-------
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_detect_paste=1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='solarized'
set background=dark
let g:solarized_termcolors=256
"colorscheme solarized
colorscheme monokain



"---------NERD-TREE SETTINGS----------
nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
"let g:nerdtree_tabs_open_on_console_startup = 1


"-------- SYNTASTIC SETTINGS---------
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = "▲"

augroup mySyntastic
    au!
    au FileType tex let b:syntastic_mode = "passive"
augroup END


"-------- TAGS SETTINGS --------------------------------
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1
let g:easytags_suppress_ctags_warning = 1
let g:tagbar_autoclose=2

nmap <silent> <leader>b :TagbarToggle<CR>
"autocmd BufEnter * nested :call tagbar#autoopen(0)

"---------GIT SETTINGS--------------
hi clear SignColumn
let g:airline#extensions#hunks#non_zero_only = 1


"----------DELIMITEMATE SETTINGS-----------------
let delimitMate_expand_cr = 1
augroup mydelimitMate
    au!
    au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
    au FileType tex let b:delimitMate_quotes = ""
    au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
    au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
augroup END

"-----------TMUX SETTINGS--------------
let g:tmux_navigator_save_on_switch = 2

"-----------LAST POSITION--------------
" Remember position of last edit and return on reopen
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"-----------CTRLP SETTINGS--------------
let g:ctrlp_show_hidden = 1

"-----------SHOW RELATIVE AND ABSOLUT LINE NUMBERS - HYBRID MODE--------------
"Ref https://jeffkreeftmeijer.com/vim-number/
set number relativenumber


"---------INDENTLINE SETTINGS-----------
"let g:indentLine_char = 'c'
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_enabled = 1
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '·'
"For code indented with tabs I think there is no need to support it, because
"you can use :set list lcs=tab:\|\ (here is a space)

"---------elzr/vim-json SETTINGS--------
let g:vim_json_syntax_conceal = 0

"--------------------------------------
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

