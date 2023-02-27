local PKGS = {

	-- packages --

	{ 'savq/paq-nvim', pin = true, opt = true },

	-- pretty --

	-- { 'rrethy/vim-hexokinase', run='make hexokinase' },
	{ 'norcalli/nvim-colorizer.lua' },

	-- treesitter handles advanced syntax highlighting
	{ 'nvim-treesitter/nvim-treesitter', run = function() vim.cmd 'TSUpdate' end },

	'nvim-treesitter/playground',

	-- automatically close tags with treesitter
	'windwp/nvim-ts-autotag',

	-- lsp setup --

	-- lsp config
	'neovim/nvim-lspconfig',

	-- autocompletion
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-path',
	'hrsh7th/cmp-cmdline',
	'hrsh7th/nvim-cmp',

	-- snippets -- 
	'L3MON4D3/LuaSnip',
	-- nvim-cmp integration
	'saadparwaiz1/cmp_luasnip',
	-- snippet library
	'rafamadriz/friendly-snippets',

	-- new verbs --

	-- change surrounding characters
	'tpope/vim-surround',

	-- add s verb to sneak
	'justinmk/vim-sneak',

	-- add gr verb to replace with register
	'vim-scripts/replacewithregister',

	-- new functions --

	-- adjust dates & times with c-a and c-x
	'tpope/vim-speeddating',

	-- neovim sudo tee replacement
	'lambdalisue/suda.vim',

	-- tab support for autocompletion
	--  'ervandew/supertab',

	-- file browser
	'preservim/nerdtree',

	-- comment faster
	'tomtom/tcomment_vim',

	-- allow plugins to opt into repeatability
	'tpope/vim-repeat',

	-- latex live preview rendering
	'xuhdev/vim-latex-live-preview',

	-- redact text
	'dbmrq/vim-redacted',

	-- fuzzyfinding
	'junegunn/fzf.vim',

	-- graphviz shortcuts
	'liuchengxu/graphviz.vim',

	-- highlight f / t search options
	'unblevable/quick-scope',

	-- these need to be configured --

	-- view git changes in project
	-- make sure colors aren't all fucked up?
	'airblade/vim-gitgutter',

	-- align stuff easily
	-- make an easier keybind?
	'godlygeek/tabular',

	-- smooth scrolling
	-- maybe try tweaking settings?
	'yuttie/comfortable-motion.vim',

	-- pretty lines
	-- better theme / get rid of parts i don't need?
	-- make sure it's not slow
	'vim-airline/vim-airline',

	-- these need to be evaluated because i don't understand them

	-- validator for neovim
	--'neomake/neomake',

}

local function clone_paq()
	local path = vim.fn.stdpath 'data' .. '/site/pack/paqs/start/paq-nvim'
	if vim.fn.empty(vim.fn.glob(path)) > 0 then
		vim.fn.system {
			'git',
			'clone',
			'--depth=1',
			'https://github.com/savq/paq-nvim.git',
			path,
		}
	end
end

local function bootstrap()
	clone_paq()

	-- load paq
	vim.cmd 'packadd paq-nvim'
	local paq = require 'paq'

	-- exit nvim after installing plugins
	vim.cmd 'autocmd User PaqDoneInstall quit'

	-- read and install packages
	paq(PKGS):install()
end

local function sync_all()
	-- package.loaded.paq = nil
	(require 'paq')(PKGS):sync()
end

return { bootstrap = bootstrap, sync_all = sync_all }
