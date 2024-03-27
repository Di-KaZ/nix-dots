MiniDeps.add({ source = "xiyaowong/transparent.nvim" })

local colorschemes = {
	{ source = "muchzill4/doubletrouble",      name = "doubletrouble" },
	{ source = "miikanissi/modus-themes.nvim", name = "modus" },
	{ source = "rebelot/kanagawa.nvim",        name = "kanagawa" },
	{ source = "loctvl842/monokai-pro.nvim",   name = "monokai-pro" },
	{ source = "bluz71/vim-moonfly-colors",    name = "moonfly" },
	{ source = "savq/melange-nvim",            name = "melange" },
	{ source = "FrenzyExists/aquarium-vim",    name = "aquarium" },
	{ source = "ramojus/mellifluous.nvim",     name = "mellifluous" },
}

MiniDeps.add("rktjmp/lush.nvim")
MiniDeps.add("zaldih/themery.nvim")

local function map(tbl, f)
	local t = {}
	for i, value in pairs(tbl) do
		t[i] = f(value)
	end
	return t;
end

local themes = map(colorschemes, function(scheme)
	MiniDeps.add(scheme.source)
	return {
		name = scheme.name,
		colorscheme = scheme.name,
	}
end)

require("themery").setup({
	themes = themes,
	themeConfigFile = "~/.config/nvim/plugins/themery.lua"
});

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
