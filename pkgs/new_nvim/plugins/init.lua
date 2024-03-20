--- Calls require on files based on priority
--- @param plugins table
local function load_plugins(plugins)
	table.sort(plugins, function(a, b) return a.priority > b.priority end)
	for _, plugin in ipairs(plugins) do
		require("plugins." .. plugin.name)
	end
end

load_plugins(
	{
		--- base
		{ name = 'basics',           priority = 1000 },
		{ name = 'colorscheme',      priority = 101 },
		{ name = 'noice',            priority = 100 },
		-- { name = 'statusline',       priority = 50 },
		{ name = 'heirline',       priority = 50 },

		-- shortcut
		{ name = 'move',             priority = 50 },
		{ name = 'comment',          priority = 50 },
		{ name = 'pairs',            priority = 50 },
		{ name = 'splitjoin',        priority = 50 },
		-- ui
		{ name = 'bufferline',       priority = 100 },
		{ name = 'starter',          priority = 100 },
		{ name = 'indentscope',      priority = 50 },
		{ name = 'reactive',         priority = 50 },
		{ name = 'clue',             priority = 50 },
		{ name = 'highlight-colors', priority = 50 },
		{ name = 'surround',         priority = 50 },
		-- lsp
		{ name = 'neodev',           priority = 55 },
		{ name = 'lsp_lines',        priority = 51 },
		{ name = 'lspconfig',        priority = 50 },
		{ name = 'lspui',            priority = 50 },
		{ name = 'completion',       priority = 50 },
		{ name = 'flutter',          priority = 50 },
		{ name = 'conform',          priority = 50 },
		{ name = 'treesitter',       priority = 50 },
		-- files management
		{ name = 'pick',             priority = 50 },
		{ name = 'files',            priority = 50 },
		{ name = 'extra',            priority = 50 },
		-- debugging
		{ name = 'dap',              priority = 50 },
		-- git
		{ name = 'gitsigns',         priority = 50 },
		{ name = 'neogit',           priority = 50 },
		-- { name = 'fugit2',           priority = 50 },
		-- terminal
		{ name = 'termim',           priority = 50 },
	}
)
