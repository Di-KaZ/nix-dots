local add = MiniDeps.add

add({ source = "muchzill4/doubletrouble" })
add({ source = "miikanissi/modus-themes.nvim" })
add({ source = "rebelot/kanagawa.nvim" })

vim.cmd('colorscheme kanagawa')

add({ source = "xiyaowong/transparent.nvim" })
require("transparent").setup({
	extra_groups = {
		"NormalFloat",
		"FloatBorder",
		"NoiceCmdlinePopupBorder",
		"NotifyBackground",
	},
})
