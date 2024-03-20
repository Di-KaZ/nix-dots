local add = MiniDeps.add

add("muchzill4/doubletrouble")
add("miikanissi/modus-themes.nvim")
add("rebelot/kanagawa.nvim")

add("wllfaria/scheming.nvim")
require("scheming").setup({
	schemes = {
		doubletrouble = {},
		kanagawa = {},
	}
})

vim.cmd('colorscheme kanagawa')

add({ source = "xiyaowong/transparent.nvim" })
require("transparent").setup({
	extra_groups = {
		"NormalFloat",
		"FloatBorder",
		"NoiceCmdlinePopupBorder",
		"NotifyBackground",
		"DiagnosticSignInfo",
	},
})
