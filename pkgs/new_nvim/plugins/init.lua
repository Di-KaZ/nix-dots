local plugins = {
	'basics',
	'colorscheme',
	'noice',
	'reactive',
	'statusline',
	'move',
	'pairs',
	'treesitter',
	'lspconfig',
	'completion',
	'pick',
	'files',
	'dap',
	'flutter',
	'lspui',
	'clue',
	'extra',
	'conform',
	'indentscope',
	'splitjoin',
	'starter',
	'neogit',
	'surround',
	'highlight-colors'
};

for _, plug in ipairs(plugins) do
	require("plugins." .. plug)
end
