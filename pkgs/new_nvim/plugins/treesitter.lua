MiniDeps.add({
	source = 'nvim-treesitter/nvim-treesitter',
	-- Use 'master' while monitoring updates in 'main'
	checkout = 'master',
	monitor = 'main',
	-- Perform action after every checkout
	hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
})

---@diagnostic disable-next-line: missing-fields
require('nvim-treesitter.configs').setup({
	ensure_installed = { 'lua', 'vimdoc' },
	highlight = { enable = true },
})
