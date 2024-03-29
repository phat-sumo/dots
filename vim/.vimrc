set nocompatible

filetype plugin indent on

" Automatically indent file
set autoindent

syntax on

" Persistent undo
set undofile
set undodir=!/.vim/undodir

" Enable mouse support
set mouse=a

" Use more advanced encryption for VimCrypt.
:setlocal cm=blowfish

" Current line shows actual number
set number
" All other lines show distance from current line
set relativenumber
" Displays line/column number in bottom right hand corner.
set ruler
" Enables filename/ruler for vim.
set laststatus=2

" Sets paste on F2.
set pastetoggle=<F2>

" Let the cursor blink when not active.
set visualbell

set encoding=utf-8

" Wrap text visually
set wrap

" Set specific width
set textwidth=80

" Let vim decide how to format
set formatoptions=tqn1

" Expandtab inserts spaces when Tab is pressed. 2 spaces per tab.
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

" Round indents to the nearest multiple of shiftwidth.
set shiftround

" Keep 3 lines below the cursor when scrolling.
set scrolloff=3

" Allow backspacing over autoindents, end of lines, and the beginning of lines.
set backspace=indent,eol,start

" Allow j and k to always move the cursor one line up or down, even in wrapped
" paragraphs.
nnoremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
nnoremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Hides buffers without closing them, even when shifting focus to another file.
set hidden

" Small performance boosts for vim.
set ttyfast
set lazyredraw

" Shows what mode you're currently in- ie, insert mode, visual mode
set showmode
" Shows what command is currently being typed.
set showcmd

"<Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

" Smart searching- case insensitive, shortcuts abound.
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch

" Disables help keys.
inoremap <F1> <ESC>:set invfullscreen<CR>
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" Enter inserts new line
noremap <CR> o<Esc>

" Fixes weird background issues.
if &term =~ '256color'
    set t_ut=
endif

set t_Co=256

" Get a dank colourscheme
set background=dark
colo vice
let g:airline_theme='vice'

" Default behaviour for vim-sneak and other plugins.
let g:sneak#s_next = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:gitgutter_enabled = 0
let g:minimap_toggle='<leader>mm'
let g:minimap_highlight='visual'
let g:airline#extensions#whitespace#enabled = 0

" Assign Space to leader key.
let mapleader = "\<Space>"

" Quick saving / exiting
nnoremap <Leader>w :w<CR>
nnoremap <Leader>x :x<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>! :q!<CR>

" Faster buffer mode
nnoremap <Leader>b <C-w>

" Fast replace
nnoremap <Leader>y "nyiw
nnoremap <Leader>r viw"np

" Quick compile
nnoremap <Leader>C :!make<CR>
nnoremap <Leader>R :!./run<CR>

" Convert c++ comments into cout statements, and vice versa.
nnoremap <Leader>d mn^vf/lcstd::cout << "<esc>A\n";<esc>`n:delmarks n<CR><C-l>
nnoremap <Leader>D mn^cf"// <esc>f\d$`n:delmarks n<CR><C-l>

nnoremap <Leader>gg :GitGutterToggle<CR>
nnoremap <Leader>a :AirlineToggle<CR>

nnoremap <Leader>l :LLPStartPreview<CR>

" Reload .vimrc while editing it
nnoremap <Leader>vim :so %<CR>

" Remap w!! to sudo-edit the file, in case you forget.
cmap w!! w !sudo tee % >/dev/null

" Let vim's unnamed buffer interact with the system clipboard.
set clipboard=unnamedplus,autoselect,unnamed

" Don't pull carraige returns in visual mode
vnoremap $ $h

" Swap ' and ` to prefer accuracy with marks
nnoremap ' `
nnoremap ` '
