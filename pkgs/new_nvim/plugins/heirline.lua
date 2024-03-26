MiniDeps.add({
	source = "rebelot/heirline.nvim",
	depends = {
		"Zeioth/heirline-components.nvim",
	},
})

local heirline = require("heirline")
local components = require("heirline-components.all")

components.init.subscribe_to_events()


heirline.load_colors(components.hl.get_colors())

heirline.setup({
	---@diagnostic disable-next-line: missing-fields
	statusline = { -- UI statusbar
		hl = { fg = "fg", bg = "bg" },
		components.component.git_branch(),
		components.component.git_diff(),
		components.component.diagnostics(),
		components.component.fill(),
		components.component.lsp(),
		components.component.nav({ percentage = false, scrollbar = false }),
	},
})
