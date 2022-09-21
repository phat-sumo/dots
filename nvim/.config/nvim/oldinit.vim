set nocompatible
filetype off
set guicursor=

" let vim-plug handle all vim plugins.
call plug#begin()

" plugin manager
Plug 'junegunn/vim-plug'

" syntax stuff

" coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" javascript syntax support
Plug 'pangloss/vim-javascript'

" latex syntax support
Plug 'vim-latex/vim-latex'

" kotlin syntax support
Plug 'udalov/kotlin-vim'

" pretty

" display colors on color codes
Plug 'rrethy/vim-hexokinase', {'do': 'make hexokinase'}

" vice colorscheme
Plug 'bcicen/vim-vice'

" new verbs

" add cs verb to change surround
Plug 'tpope/vim-surround'

" add s verb to sneak
Plug 'justinmk/vim-sneak'

" add gr verb to replace with register
Plug 'vim-scripts/replacewithregister'

" new functions

" adjust dates & times with c-a and c-x
Plug 'tpope/vim-speeddating'

" neovim sudo tee replacement
Plug 'lambdalisue/suda.vim'

" tab support for autocompletion
" Plug 'ervandew/supertab'

" file browser
Plug 'preservim/nerdtree'

" comment faster
Plug 'tomtom/tcomment_vim'

" allow plugins to opt into repeatability
Plug 'tpope/vim-repeat'

" latex live preview rendering
Plug 'xuhdev/vim-latex-live-preview'

" redact text
Plug 'dbmrq/vim-redacted'

" fuzzyfinding
Plug 'junegunn/fzf.vim'

" graphviz shortcuts
Plug 'liuchengxu/graphviz.vim'

" highlight f / t search options
Plug 'unblevable/quick-scope'

" these need to be configured

" view git changes in project
" make sure colors aren't all fucked up?
Plug 'airblade/vim-gitgutter' 

" align stuff easily
" make an easier keybind?
Plug 'godlygeek/tabular'

" smooth scrolling
" maybe try tweaking settings?
Plug 'yuttie/comfortable-motion.vim'

" pretty lines
" better theme / get rid of parts i don't need?
" make sure it's not slow 
Plug 'vim-airline/vim-airline'

" these need to be evaluated because i don't understand them

" validator for neovim
Plug 'neomake/neomake'

call plug#end()

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

" coc may want this to be 2
set cmdheight=1

set updatetime=300

set shortmess+=c

if has("nvim-0.5.0") || has("patch-8.1.1564")
	set signcolumn=number
else
	set signcolumn=yes
endif

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
nnoremap <silent> <C-l> :nohl<cr><C-l>

" enter inserts new line
noremap <cr> o<Esc>

" quick saving / exiting
nnoremap <leader>w :w<cr>
nnoremap <leader>x :x<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>! :q!<cr>

" faster buffer mode
nnoremap <leader>b <c-w>

nnoremap <leader>a :Ag<cr>

nnoremap <leader>o :FZF<cr>

" Toggle NERDTree
nnoremap <leader>n :NERDTreeToggle<cr>

" quick compile
" is there a better way to do this?
nnoremap <leader>C :!make<cr>
nnoremap <leader>R :!./run<cr>

" edit todo!
" maybe we can sync this with nextcloud later?
nnoremap <leader>todo :vs ~/Documents/Drive/TODO/todo.md<cr>

" convert c++ comments into cout statements, and vice versa.
" interesting idea- maybe an addon for tcomment?
nnoremap <leader>d mn^vf/lcstd::cout << "<esc>A\n";<esc>`n:delmarks n<cr><C-l>
nnoremap <leader>D mn^cf"// <esc>f\d$`n:delmarks n<cr><C-l>

nnoremap <leader>gg :GitGutterToggle<cr>

nnoremap <leader>l :LLPStartPreview<cr>

" reload .vimrc while editing it
nnoremap <leader>vim :so %<cr>

" fix tabs
nnoremap <leader>tab gg=G

vnoremap <leader>h :Redact<cr>
nnoremap <leader>h :Redact<cr>

vnoremap <leader>s :Redact!<cr>
nnoremap <leader>s :Redact!<cr>

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
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<cr>

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

" let g:SuperTabDefaultCompletionType = "<c-n>"

" use tab for trigger completion with characters ahead and navigate
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" make <cr> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<cr>\<c-r>=coc#on_enter()\<CR>"

" use `[g` and `]g` to navigate diagnostics
" use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" goto code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<cr>

function! s:show_documentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
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

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

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

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" " Mappings for CoCList
" " Show all diagnostics.
" nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions.
" nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" " Show commands.
" nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document.
" nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols.
" nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list.
" nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

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
