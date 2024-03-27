MiniDeps.add('akinsho/git-conflict.nvim')

---@diagnostic disable-next-line: missing-fields
require('git-conflict').setup({
	default_mappings = false,
})
