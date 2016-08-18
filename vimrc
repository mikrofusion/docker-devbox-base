"set backupdir=~/.vim/bkup               " Directories for bkup files
"set directory=~/.vim/bkup               " Directories for swp files

set encoding=utf-8                      " The encoding displayed.
set fileencoding=utf-8                  " The encoding written to file.

set nocompatible                        " be iMproved, required for Vundle
filetype off                            " required for Vundle

" prevent going into Ex mode
map Q <Nop>

" set runtime path for Vundle
set rtp+=~/.vim/bundle/Vundle.vim/
" intialize Vundle
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/vundle'

" color theme
Plugin 'nanotech/jellybeans.vim'

" vimux (VIM TMUX integration)
Plugin 'benmills/vimux'

" Language support
Plugin 'gkz/vim-ls'
Plugin 'digitaltoad/vim-jade'
Plugin 'tpope/vim-rails'
Plugin 'vim-ruby/vim-ruby'
Plugin 'pangloss/vim-javascript'
Plugin 'sunaku/vim-ruby-minitest'
Plugin 'tpope/vim-markdown'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'chrisbra/csv.vim'
Plugin 'tpope/vim-git'
Plugin 'slim-template/vim-slim'
Plugin 'mileszs/ack.vim'

" indentation
Plugin 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']
let g:indent_guides_guide_size=1

" ejs
au BufNewFile,BufRead *.ejs set filetype=html

" allow seamless TMUX / VIM integration
Plugin 'christoomey/vim-tmux-navigator'

" allow git changes to be seen in gutter
Plugin 'airblade/vim-gitgutter'

" show buffers
Plugin 'jeetsukumaran/vim-buffergator'

" use unimpaired for buffer switching [-b and ]-b
" also used for line bubbling
Plugin 'tpope/vim-unimpaired'

Plugin 'kien/ctrlp.vim'
let g:ctrlp_map = '<c-t>'
let g:ctrlp_cmd = 'CtrlP'

" Janus libraries
Plugin 'ap/vim-css-color'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-endwise'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'
Plugin 'mattn/gist-vim'
Plugin 'sjl/gundo.vim'
Plugin 'edsono/vim-matchit'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'chrisbra/NrrwRgn'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-repeat'
Plugin 'ervandew/supertab'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/syntastic'
Plugin 'majutsushi/tagbar'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'vim-scripts/vimwiki'
Plugin 'thinca/vim-visualstar'
Plugin 'skalnik/vim-vroom'
Plugin 'mattn/webapi-vim'
Plugin 'elixir-lang/vim-elixir'

Plugin 'slashmili/alchemist.vim'
Plugin 'pbrisbin/vim-mkdir.git'

" Zoom in and out of current pane (C-W, O)
Plugin 'itspriddle/ZoomWin'

" set vim root to the project root
Plugin 'airblade/vim-rooter'

" visualization of vim markers
Plugin 'kshenoy/vim-signature'

call vundle#end()
filetype plugin indent on

syntax on
set number
set ruler
set background=dark
set t_Co=256                         " force vim to use 256 colors

if filereadable("~/.vim/bundle/jellybeans.vim/colors/jellybeans.vim")
  colorscheme jellybeans               " user jellybeans scheme
endif

" make the colors pretty
highlight Normal ctermbg=none
highlight CursorLineNr ctermbg=233
highlight LineNr ctermbg=232
" Gitgutter
highlight SignColumn ctermbg=none

" Spacing
set wm=0
set tw=0
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab ts=2 sw=2 ai
set autoindent
set smartindent

" set the cursor to a vertical line in insert mode and a solid block in command mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" causes errors when not running in TMUX
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
"
" upon hitting escape to change modes, send successive move-left and move-right commands to immediately redraw the cursor
inoremap <special> <Esc> <Esc>hl

" don't blink the cursor
set guicursor+=i:blinkwait0

" Show trailing whitespace
set list listchars=tab:\ \ ,trail:.

" Bubble lines
nmap <C-k> [e
nmap <C-j> ]e
vmap <C-k> [egv
vmap <C-j> ]egv


" Searching
set hlsearch
set incsearch
set ignorecase

set nowrap

" always show the status bar (want this for airline)
set laststatus=2

" highlight the active line
set cursorline
hi CursorLine cterm=underline ctermbg=NONE

" make make grey after line 80
let &colorcolumn=join(range(81,999),",")
highlight ColorColumn ctermbg=232 guibg=#202020

" only show highlighted line in active pane
augroup BgHighlight
    autocmd!
    autocmd WinEnter * set cul
    autocmd WinLeave * set nocul
augroup END
"
" remap jj to escape
inoremap jj <esc>

" NERDTree 
map <leader>n :NERDTreeToggle<CR>

" close wim if only window left open is a nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" easier split navigation
nnoremap <silent> <C-Right> <c-w>l
nnoremap <silent> <C-Left> <c-w>h
nnoremap <silent> <C-Up> <c-w>k
nnoremap <silent> <C-Down> <c-w>j

" toggle search highlighting
nnoremap <silent> <SPACE> :set hlsearch!<CR>

" quicker ag access
nnoremap <leader>a :Ag

" shortcuts for splitting the screen
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>s <C-w>s<C-w>l

" sytax highlighting for ejs files
au BufNewFile,BufRead *.ejs set filetype=html

if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard

  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif

let g:ackprg = 'ag --vimgrep --smart-case'
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack
