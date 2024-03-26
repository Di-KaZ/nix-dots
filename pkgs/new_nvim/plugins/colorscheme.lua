MiniDeps.add("muchzill4/doubletrouble")
MiniDeps.add("miikanissi/modus-themes.nvim")
MiniDeps.add("rebelot/kanagawa.nvim")
MiniDeps.add("rktjmp/lush.nvim")
MiniDeps.add("metalelf0/jellybeans-nvim")
MiniDeps.add("wllfaria/scheming.nvim")

require("scheming").setup({
	schemes = {
		doubletrouble = {},
		kanagawa = {},
	}
})

vim.cmd('colorscheme jellybeans-nvim')

MiniDeps.add({ source = "xiyaowong/transparent.nvim" })
require("transparent").setup({
	extra_groups = {
		"NormalFloat",
		"FloatBorder",
		"NoiceCmdlinePopupBorder",
		"NotifyBackground",
		"DiagnosticSignInfo",
	},
})

vim.cmd("TransparentEnable")
