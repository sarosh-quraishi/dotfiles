" ViM Configuration File
" Ben Hilburn
" bhilburn@gmail.com
"
" Recently re-done, pulling some nifty features from Steve Losh's vimrc:
" Author: Steve Losh <steve@stevelosh.com>
" Source: http://bitbucket.org/sjl/dotfiles/src/tip/vim/

" To enable Pathogen, we have to first disable the filetype, load the bundles,
" nad then re-enable.
filetype off
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

" Ignore compatibility issues with Vi.
set nocompatible

" General Options
set autoread
set history=1000
set scrolloff=15
set showmode
set showcmd
set ruler
set number
set nonumber
set norelativenumber
set cursorline
set hidden
set title
set visualbell
set autoindent
set matchtime=3
set ttyfast
set cpoptions+=J
set list
set listchars=tab:▸\ ,eol:¬
set shell=/bin/zsh
set lazyredraw
set showbreak=↪

" Set options regarding the undo history and undo tree depth
set undofile
set undoreload=10000
set undolevels=512
set modelines=0

" Wildmode options, for command-line tab completion
set wildmenu
set wildchar=<Tab>
set wildmode=list:longest,full
set wildignore+=*.pyc,.hg,.git

" Set the terminal font encoding
set encoding=utf-8
set termencoding=utf-8

" Save when losing focus
au FocusLost * :wa

" Mouse options
set mouse=a
set mousemodel=popup

" Intuitive backspacing in insert mode
set backspace=indent,eol,start

" Spacing and tabbing
set expandtab
set smarttab
set softtabstop=4
set shiftwidth=4
set tabstop=4
set wrap
set textwidth=80
set formatoptions=qrn1
set colorcolumn=+1

" Get those annoying temporary files out of the working directory
set undodir=~/.vim/tmp/undo/     " undo files
set backupdir=~/.vim/tmp/backup/ " backups
set directory=~/.vim/tmp/swap/   " swap files
set backup                       " enable backups
let g:yankring_history_dir='~/.vim/tmp/yankring'

" Leader key remapping
let mapleader = ","
let maplocalleader = "\\"
map <leader><space> :noh<cr>

" Background, colorscheme, etc
set background=dark
set t_Co=256
colorscheme molokai
syntax on

" Regex fixes
nnoremap / /\v
vnoremap / /\v

" Searching & Replacing
set hlsearch
set ignorecase
set smartcase
set incsearch
set showmatch
runtime macros/matchit.vim

" Keep search matches in the middle of the window.
nnoremap * *zzzv
nnoremap # #zzzv
nnoremap n nzzzv
nnoremap N Nzzzv

" Pushing tab is much faster than shift-5 to match braces
map <tab> %

" L is easier to type than shift-4 for EOL shortcut
noremap L $

" Allow us to select non-text blocks while in visual mode for lazy stuff
set virtualedit+=block

" Some quick shortcuts for yanking and deleting lines.
nnoremap Y y$
nnoremap D d$

" Reselect text that was just pasted.
nnoremap <leader>v V`]

" Open a Quickfix window for the last search
nnoremap <silent> <leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" Fix linewise visual selection of various text objects
nnoremap Vit vitVkoj
nnoremap Vat vatV
nnoremap Vab vabV
nnoremap VaB vaBV

" Error navigation {{{
"
"             Location List     QuickFix Window
"            (e.g. Syntastic)     (e.g. Ack)
"            ----------------------------------
" Next      |     M-k               M-Down     |
" Previous  |     M-l                M-Up      |
"            ----------------------------------
" Ripped directly from Steve Losh
"
nnoremap ˚ :lnext<cr>zvzz
nnoremap ¬ :lprevious<cr>zvzz
inoremap ˚ <esc>:lnext<cr>zvzz
inoremap ¬ <esc>:lprevious<cr>zvzz
nnoremap <m-Down> :cnext<cr>zvzz
nnoremap <m-Up> :cprevious<cr>zvzz
" }}}

" Easy buffer navigation instead of the whole Ctrl-w crap.
noremap <C-j>  <C-w>h
noremap <C-k>  <C-w>j
noremap <C-l>  <C-w>k
noremap <C-g>  <C-w>l
noremap <leader>g <C-w>v<C-w>l

" Map ,s to show whitespace so I can easily fix mixed tabs and spaces and
" other such nonsense.
set listchars=tab:>-,trail:·
",eol:$
nmap <silent> <leader>s :set nolist!<CR>

" Folding Settings
set foldlevelstart=0
set foldenable 
set foldmethod=indent 
set foldlevel=100 
set foldopen-=search
set foldopen-=undo

" Spacebar to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" Make zO recursively open whatever top level fold we're in, no matter where the
" cursor happens to be.
nnoremap zO zCzO

" Also ripped this function directly from Steve Losh:
function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()

" Losh's fixes for annoying keys; his comments remain intact for posterity.
" Fuck you, help key.
noremap <F1> :set invfullscreen<CR>
inoremap <F1> <ESC>:set invfullscreen<CR>a

" Fuck you too, manual key.
nnoremap K <nop>

" Stop it, hash key.
inoremap # X<BS>#

" Filetype-specific formatting
set formatoptions+=t,c,r,o,n
au FileType c,cpp,h set cindent formatoptions+=ro foldmethod=syntax
au FileType c set omnifunc=ccomplete#Complete
au FileType make set noexpandtab shiftwidth=8
au FileType tex SPCheck let dialect='US'
au Syntax {cpp,c,idl} runtime syntax/doxygen.vim
au BufRead,BufNewFile PKGBUILD set ts=2 sts=2 et sw=2
au FileType vim setlocal foldmethod=marker

" Filetype recognitition
au BufNewFile,BufRead .Xdefaults* set filetype=xdefaults
au BufNewFile,BufRead *-MIB.txt set filetype=mib

" Key mappings - ViM Explorer
nnoremap <silent> <F9> :Explore<CR>

" Key mappings - ViM tabs
nnoremap <silent> <F10> :tabp<CR>
nnoremap <silent> <F11> :tabn<CR>
nnoremap <silent> <F12> :tabnew<CR>

" Key mappings - silly quotes
nnoremap ` '
nnoremap ' `

" Key mappings - toggle paste mode
set pastetoggle=<F8>

" Key mappings - Yankring
nnoremap <silent> <F6> :YRShow<cr>

" Key mappings - Ack
map <leader>a :Ack 

" Key mappings - clean whitespace
map <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Status line settings
set laststatus=2
set statusline=%-3.3n\ %f%(\ %r%)%(\ %#WarningMsg#%m%0*%)%=(%l,\ %c)\ %P\ [%{&encoding}:%{&fileformat}]%(\ %w%)\ %y\
set shortmess+=aI
hi StatusLine term=inverse cterm=NONE ctermfg=white ctermbg=black
hi StatusLineNC term=none cterm=NONE ctermfg=darkgray ctermbg=black

" Some other fun graphical tidbits
highlight SpellBad term=underline gui=undercurl guisp=Orange
set fillchars=vert:│
set guicursor=n-c:block-Cursor-blinkon0
set guicursor+=v:block-vCursor-blinkon0
set guicursor+=i-ci:ver20-iCursor

" Better Completion
set completeopt=longest,menuone
inoremap <expr> <CR>  pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-p> pumvisible() ? '<C-n>'  : '<C-n><C-r>=pumvisible() ? "\<lt>up>" : ""<CR>'
inoremap <expr> <C-n> pumvisible() ? '<C-n>'  : '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" Rainbow parentheses
nmap <leader>r :RainbowParenthesesToggle<CR>

" NERDTree settings
map <F2> :NERDTreeToggle<cr>
let NERDTreeIgnore=['.vim$', '\~$', '.*\.pyc$', 'pip-log\.txt$', 'whoosh_index', 'xapian_index', '.*.pid', 'monitor.py', '.*-fixtures-.*.json', '.*\.o']

" Enable ViM's included LISP prettiness
let g:lisp_rainbow = 1

" Useful for editing syntax files. Thanks, Losh.
" Show the stack of syntax hilighting classes affecting whatever is under the
" cursor.
function! SynStack() " {{{
  if !exists("*synstack")
    return
  endif

  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
nmap <M-S> :call SynStack()<CR>

" Error toggles, again, from Steve Losh
command! ErrorsToggle call ErrorsToggle()
function! ErrorsToggle() " {{{
  if exists("w:is_error_window")
    unlet w:is_error_window
    exec "q"
  else
    exec "Errors"
    lopen
    let w:is_error_window = 1
  endif
endfunction " }}}

command! -bang -nargs=? QFixToggle call QFixToggle(<bang>0)
function! QFixToggle(forced) " {{{
  if exists("g:qfix_win") && a:forced == 0
    cclose
    unlet g:qfix_win
  else
    copen 10
    let g:qfix_win = bufnr("$")
  endif
endfunction " }}}

nmap <silent> <f3> :ErrorsToggle<cr>
nmap <silent> <f4> :QFixToggle<cr>


" Taglist settings
let Tlist_Process_File_Always = 1
let Tlist_Auto_Highlight_Tag = 1
let Tlist_Auto_Update = 1
let Tlist_Enable_Fold_Column = 1
let Tlist_Highlight_Tag_On_BufEnter = 1
let Tlist_Max_Tag_Length = 35
let Tlist_Use_Right_Window = 1
let Tlist_Inc_Winwidth = 0
let Tlist_WinWidth = 40

" OmniCPPComplete settings
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_NamespaceSearch = 1
let OmniCpp_DisplayMode = 1
let OmniCpp_ShowScopeInAbbr = 0
let OmniCpp_ShowPrototypeInAbbr = 0
let OmniCpp_ShowAccess = 1
let OmniCpp_DefaultNamespaces = ["std"]
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteScope = 0
let OmniCpp_SelectFirstItem = 0

" SuperTab plugin settings
let g:SuperTabDefaultCompletionType = "<C-P>"
let g:SuperTabRetainCompletionType = 1
let g:SuperTabMappingForward = '<s-tab>'
let g:SuperTabMappingBackward = '<s-c-tab>'

