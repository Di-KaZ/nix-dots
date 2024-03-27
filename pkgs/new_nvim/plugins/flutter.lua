MiniDeps.add({
	source = "akinsho/flutter-tools.nvim",
	depends = {
		"nvim-lua/plenary.nvim",
		"stevearc/dressing.nvim",
	},
})

require("flutter-tools").setup(
	{
		dev_log = {
			enabled = false,
		},
		widget_guides = {
			enabled = false,
		},
		debugger = {
			enabled = true,
			run_via_dap = true,
			exception_breakpoints = {},
		},
	}
)
