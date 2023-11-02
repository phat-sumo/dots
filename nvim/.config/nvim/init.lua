setmetatable(_G, { __index = vim })
cmd 'runtime vimrc'

local _utils = require 'utils'
local command = _utils.command
local keymap = _utils.keymap
local augroup = _utils.augroup

local _plugins = require 'plugins'

do -- bootstrap paq
	local install_path = fn.stdpath('data')..'/site/pack/paqs/opt/paq-nvim'

	if fn.empty(fn.glob(install_path)) > 0 then
		_plugins.bootstrap()
	end

	keymap('<leader>up', function()
		package.loaded.plugins = nil
		_plugins.sync_all()
	end)

end

require 'gitsigns'.setup {
	signcolumn = false,
	on_attach = function(bufindex)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufindex
			vim.keymap.set(mode, l, r, opts)
		end


		map('n', '<leader>gg', function()
			gs.toggle_signs()
			vim.o.signcolumn = vim.o.signcolumn == "yes" and "no" or "yes"
		end)
	end
}

-- gisigns highlighting
vim.api.nvim_set_hl(0, 'GitsignsAdd', { link = 'luaCond'})
vim.api.nvim_set_hl(0, 'GitsignsChange', { link = 'luaString'})
vim.api.nvim_set_hl(0, 'GitsignsDelete', { link = 'luaCond'})
vim.api.nvim_set_hl(0, 'GitsignsUntracked', { link = 'luaStatement'})

require 'colorizer'.setup()

require 'lsp'

require 'treesitter'
