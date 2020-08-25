set nocompatible

" Let Vundle handle all vim plugins.
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Enable sneak movement on s 
Plugin 'justinmk/vim-sneak'

" Replace word with innamed register
Plugin 'vim-scripts/ReplaceWithRegister'

" On-the-fly syntax checks.
Plugin 'maralla/validator.vim'

" Autocompletion for C/C++.
Plugin 'Rip-Rip/clang_complete'

" Tab support for autocompletion.
Plugin 'ervandew/supertab'

" File fuzzy search
Plugin 'ctrlpvim/ctrlp.vim'

" Better JavaScript support.
Plugin 'pangloss/vim-javascript'

" Directory exploration
Plugin 'scrooloose/nerdtree'

" Minimap plugin!
Plugin 'severin-lemaignan/vim-minimap'

" Autocomment and remover
Plugin 'tomtom/tcomment_vim'

" New verb- change surrounding item
Plugin 'tpope/vim-surround'

" Better searching with ack/ag
Plugin 'mileszs/ack.vim'

" View git changes in project
Plugin 'airblade/vim-gitgutter' 

" Vala syntax highlighting
Plugin 'arrufat/vala.vim'

" Allow plugins to opt into repeatability
Plugin 'tpope/vim-repeat'

" Align code easily
Plugin 'godlygeek/tabular'

"Smooth scrolling
Plugin 'yuttie/comfortable-motion.vim'

" Pretty lines
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Typescript highlighting
Plugin 'leafgarland/typescript-vim'

" Highlight colors to match
Plugin 'lilydjwg/colorizer'

" LaTeX rendering
Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'vim-latex/vim-latex'

call vundle#end()

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

" Toggle NERDTree
nnoremap <Leader>f :NERDTreeToggle<CR>

" Fast replace
nnoremap <Leader>y "nyiw
nnoremap <Leader>r viw"np

" Quick compile
nnoremap <Leader>C :!make<CR>
nnoremap <Leader>R :!./run<CR>

" Edit todo!
nnoremap <Leader>todo :vs ~/Documents/Drive/TODO/todo.md<CR>

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

" Disable valadoc syntax highlight
"let vala_ignore_valadoc = 1

" Enable comment strings
let vala_comment_strings = 1

" Highlight space errors
" let vala_space_errors = 1
" Disable trailing space errors
"let vala_no_trail_space_error = 1
" Disable space-tab-space errors
let vala_no_tab_space_error = 1

" Minimum lines used for comment syncing (default 50)
"let vala_minlines = 120

let g:rust_recommended_style = 0

let g:livepreview_previewer = 'zathura'
let g:Tex_CompileRule_pdf = "pdf"



