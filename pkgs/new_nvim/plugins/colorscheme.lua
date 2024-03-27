MiniDeps.add("muchzill4/doubletrouble")
MiniDeps.add("miikanissi/modus-themes.nvim")
MiniDeps.add("rebelot/kanagawa.nvim")
MiniDeps.add("rktjmp/lush.nvim")
MiniDeps.add("metalelf0/jellybeans-nvim")
MiniDeps.add("wllfaria/scheming.nvim")
MiniDeps.add("loctvl842/monokai-pro.nvim")
MiniDeps.add("bluz71/vim-moonfly-colors")
MiniDeps.add({ source = "xiyaowong/transparent.nvim" })

require("scheming").setup({
	schemes = {
		doubletrouble = {},
		kanagawa = {},
	}
})

vim.cmd('colorscheme kanagawa')

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
