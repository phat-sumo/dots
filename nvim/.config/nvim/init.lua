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

require 'colorizer'.setup()

