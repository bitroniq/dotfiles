" Based on:
" https://github.com/skwp/dotfiles
" https://github.com/souravchk/dotfiles/blob/master/vimrc

syntax on

set nocompatible
set backspace=indent,eol,start
set incsearch
set hlsearch
set number                      " Show line numbers
set cursorline                  " Highlight the currently selected line
"set undolevels=1000             " Set undo amount to 1000
set ignorecase                  " Enable case insenstive search
set ruler                       " show current position at bottom
"set list                        " show invisible characters
set list listchars=tab:»\ ,trail:· "Show invisible tabs for tab indented files
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
Plugin 'ryanoasis/vim-devicons'
Plugin 'dense-analysis/ale' "ALE (Asynchronous Lint Engine) linting
                            "(syntax checking and semantic errors)
                            " :ALEToggle

Plugin 'Yggdroot/indentLine' "displaying thin vertical lines at each indentA
"Plugin 'nathanaelkane/vim-indent-guides' "isually displaying indent levels
Plugin 'elzr/vim-json'
Plugin 'godlygeek/tabular' "Plugin to allow easy alignment - try :Tab /=
Plugin 'severin-lemaignan/vim-minimap'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'

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
colorscheme solarized
"colorscheme monokain

"---------NERD-TREE SETTINGS----------
nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
"let g:nerdtree_tabs_open_on_console_startup = 1
autocmd BufEnter NERD_tree* :LeadingSpaceDisable "Neeeded if indentLine is on

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

"-----------RELATIVE NUMBER TOGGE-------
"https://stackoverflow.com/questions/42566459/how-to-display-wrapped-relative-line-number-in-vim
"Add the code below to your .vimrc file, then you can use leadernt to toggle
"the number.
"Leader is the \ key

function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

nnoremap <leader>n :call NumberToggle()<cr>

"---------INDENTLINE SETTINGS-----------
"let g:indentLine_char = '|'
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_enabled = 1
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '·'
"For code indented with tabs I think there is no need to support it, because
"you can use :set list lcs=tab:\|\ (here is a space)

"--------INDENTGUIDE SETTINGS-----------
"let g:indent_guides_enable_on_vim_startup = 1
"let g:indent_guides_start_level = 1
"let g:indent_guides_guide_size = 1
"let g:indent_guides_auto_colors = 1
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=grey ctermbg=3
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=blue ctermbg=4

"---------elzr/vim-json SETTINGS--------
let g:vim_json_syntax_conceal = 0

"---------vim-minimap SETTINS----------
let g:minimap_highlight='Visual'
"Usage
":Minimap to show the minimap, :MinimapClose to hide it.
"Default mappings: <Leader>mm to display the minimap, <Leader>mc to close it.
"To overwrite the default keybindings, using following settings in ``.vimrc'':
"let g:minimap_show='<leader>ms'
"let g:minimap_update='<leader>mu'
"let g:minimap_close='<leader>gc'
"let g:minimap_toggle='<leader>gt'
let g:minimap_toggle='<leader>m'
"
"Leader key is usually "\" - you have 1s to type mm later

"------------------------------------
"https://jeffkreeftmeijer.com/vim-number/
"Funtion to show relative number only on focus
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
"--------COC settings (from their example-------------------------------
"--------https://github.com/neoclide/coc.nvim--------------------------
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
"-----------------------------------------------------------------------------

