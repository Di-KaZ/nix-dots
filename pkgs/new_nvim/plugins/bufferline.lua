MiniDeps.add({
	source = "akinsho/bufferline.nvim",
	deppends = {
		"nvim-tree/nvim-web-devicons",
	}
})

local bufferline = require("bufferline")

bufferline.setup({
	options = {
		-- separator_style = "slope"
	}
})

vim.g.transparent_groups = vim.list_extend(
	vim.g.transparent_groups or {},
	vim.tbl_map(function(v)
		return v.hl_group
	end, vim.tbl_values(require('bufferline.config').highlights))
)
