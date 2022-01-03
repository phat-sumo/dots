set nocompatible
filetype off
set guicursor=

" let vundle handle all vim plugins.
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#rc("~/.config/nvim/bundle")
call vundle#begin()

" plugin manager
Plugin 'vundlevim/vundle.vim'

" firefox stuff

Plugin 'glacambre/firenvim'

" syntax stuff

" javascript syntax support
Plugin 'pangloss/vim-javascript'

" latex syntax support
Plugin 'vim-latex/vim-latex'

" kotlin syntax support
Plugin 'udalov/kotlin-vim'

" pretty

" display colors on color codes
Plugin 'rrethy/vim-hexokinase'

" vice colorscheme
Plugin 'bcicen/vim-vice'

" new verbs

" add cs verb to change surround
Plugin 'tpope/vim-surround'

" add s verb to sneak
Plugin 'justinmk/vim-sneak'

" add gr verb to replace with register
Plugin 'vim-scripts/replacewithregister'

" new functions

" adjust dates & times with c-a and c-x
Plugin 'tpope/vim-speeddating'

" neovim sudo tee replacement
Plugin 'lambdalisue/suda.vim'

" tab support for autocompletion
Plugin 'ervandew/supertab'

" file browser
Plugin 'preservim/nerdtree'

" comment faster
Plugin 'tomtom/tcomment_vim'

" allow plugins to opt into repeatability
Plugin 'tpope/vim-repeat'

" latex live preview rendering
Plugin 'xuhdev/vim-latex-live-preview'

" redact text
Plugin 'dbmrq/vim-redacted'

" fuzzyfinding
Plugin 'junegunn/fzf.vim'

" graphviz shortcuts
Plugin 'liuchengxu/graphviz.vim'

" highlight f / t search options
Plugin 'unblevable/quick-scope'

" these need to be configured

" view git changes in project
" make sure colors aren't all fucked up?
Plugin 'airblade/vim-gitgutter' 

" align stuff easily
" make an easier keybind?
Plugin 'godlygeek/tabular'

" smooth scrolling
" maybe try tweaking settings?
Plugin 'yuttie/comfortable-motion.vim'

" pretty lines
" better theme / get rid of parts i don't need?
" make sure it's not slow 
Plugin 'vim-airline/vim-airline'

" these need to be evaluated because i don't understand them

" validator for neovim
Plugin 'neomake/neomake'

call vundle#end()

" look & feel

filetype plugin indent on

syntax on

set mouse=a

set number
set relativenumber

set visualbell

set encoding=utf-8

" persistent undo
set undofile
set undodir=~/.config/nvim/undodir

" unnamed buffer is clipboard
set clipboard=unnamedplus

" make statusbar not freak out
set laststatus=2
set ruler

set autoindent

" wrap text with eol
set wrap
set linebreak
set textwidth=0

autocmd bufreadpre *.txt setlocal textwidth=82
autocmd bufreadpre *.md setlocal textwidth=82

" stop automatically commenting
" this needs to be tweaked
autocmd filetype * set fo+=jq
autocmd filetype * set fo-=crolt
autocmd filetype postscr setlocal indentexpr=

" 2-space tabs
" FIX THIS
set noexpandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
" use autocommand to set filetype-specific 
" shiftwidths and stop python from being dumb
autocmd filetype python setlocal noexpandtab tabstop=2 shiftwidth=2 softtabstop=2
" display cursor to the left of tabs
set listchars=tab:\ \  list

" round indents to nearest shiftwidth
set shiftround

" lines from cursor when scrolling
set scrolloff=3

" hides buffers without closing them, even when shifting focus to another file.
set hidden

" small performance boosts
set ttyfast
set lazyredraw

set showmode
set showcmd

" case insensitive searching
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch

" keybinds

" spaceleader
let mapleader = "\<Space>"

" unmap f1 as help
nmap <F1> <nop>
imap <F1> <nop>

" sets paste on f2.
set pastetoggle=<F2>

" allow backspacing over autoindents, end of lines, and the beginning of lines
set backspace=indent,eol,start

" allow j and k to always move the cursor one line up or down, 
" even in wrapped paragraphs
nnoremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
nnoremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" center on search
nnoremap n nzz
nnoremap N Nzz

" ctrl+l redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

" enter inserts new line
noremap <CR> o<Esc>

" quick saving / exiting
nnoremap <Leader>w :w<CR>
nnoremap <Leader>x :x<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>! :q!<CR>

" faster buffer mode
nnoremap <Leader>b <C-w>

nnoremap <Leader>a :Ag<CR>

nnoremap <Leader>o :FZF<CR>

" Toggle NERDTree
nnoremap <Leader>f :NERDTreeToggle<CR>

" quick compile
" is there a better way to do this?
nnoremap <Leader>C :!make<CR>
nnoremap <Leader>R :!./run<CR>

" edit todo!
" maybe we can sync this with nextcloud later?
nnoremap <Leader>todo :vs ~/Documents/Drive/TODO/todo.md<CR>

" convert c++ comments into cout statements, and vice versa.
" interesting idea- maybe an addon for tcomment?
nnoremap <Leader>d mn^vf/lcstd::cout << "<esc>A\n";<esc>`n:delmarks n<CR><C-l>
nnoremap <Leader>D mn^cf"// <esc>f\d$`n:delmarks n<CR><C-l>

nnoremap <Leader>gg :GitGutterToggle<CR>

nnoremap <Leader>l :LLPStartPreview<CR>

" reload .vimrc while editing it
nnoremap <Leader>vim :so %<CR>

" fix tabs
nnoremap <Leader>tab gg=G

vnoremap <Leader>h :Redact<CR>
nnoremap <Leader>h :Redact<CR>

vnoremap <Leader>s :Redact!<CR>
nnoremap <Leader>s :Redact!<CR>

" remap w!! to sudo-edit the file
cmap w!! w suda://%

" dont grab end of line in visual
vnoremap $ $h

" swap ' and ` to prefer accuracy with marks
nnoremap ' `
nnoremap ` '

" figure out what syntax highlighting group is under cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" pretty

" fixes weird background issues.
if &term =~ '256color'
    set t_ut=
endif

set t_Co=256

set termguicolors

set background=dark
colo rend

" environment variables for plugins

let g:fzf_layout = { 'window': {'width': 0.9, 'height': 0.4, 'yoffset': 1, 'border': 'sharp', 'highlight': 'Conditional'} }

let g:fzf_colors = 
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'PreProc'],
  \ 'fg+':     ['fg', 'Normal'],
  \ 'bg+':     ['bg', 'Normal'],
  \ 'hl+':     ['fg', 'Conditional'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['bg', 'Normal'],
  \ 'prompt':  ['fg', 'PreProc'],
  \ 'pointer': ['fg', 'Conditional'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'PreProc'],
  \ 'header':  ['fg', 'Comment'] }

let g:airline_theme='rend'
let g:airline#extensions#whitespace#enabled = 0
let g:airline_powerline_fonts=0

let g:Hexokinase_highlighters = ['backgroundfull']
let g:Hexokinase_optInPatterns = 'full_hex,triple_hex,rgb,rgba,hsl,hsla'

let g:sneak#s_next = 1

let g:SuperTabDefaultCompletionType = "<c-n>"

let g:gitgutter_enabled = 0

let g:rust_recommended_style = 0

let g:livepreview_previewer = 'zathura'
let g:Tex_CompileRule_pdf = "pdf"

let g:graphviz_output_format = 'png'
let g:graphviz_viewer = 'sxiv'

" quick-scope highlight targets
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" firenvim config object
let g:firenvim_config = { 
	\ 'globalSettings': {
		\ 'alt': 'all',
	\  },
	\ 'localSettings': {
		\ '.*': {
			\ 'cmdline': 'neovim',
			\ 'content': 'text',
			\ 'priority': 0,
			\ 'selector': 'textarea',
			\ 'takeover': 'always',
		\ },
	\ }
\ }

" define easier way to ignore domains
let fc = g:firenvim_config['localSettings']
let fc['https?://messages\.google\.com'] = { 'takeover': 'never', 'priority': 1 }
let fc['https?://mail\.google\.com'] = { 'takeover': 'always', 'priority': 1 }
let fc['localhost:8888'] = { 'takeover': 'never', 'priority': 1 }

" make firenvim fonts not unthinkably massive
set guifont=Monoid:h8
