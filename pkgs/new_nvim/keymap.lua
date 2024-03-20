vim.g.mapleader = " "

local map = vim.keymap.set

--- sets a normal keymap preprending <CMD> and appending <CR> with a description
--- @param keymap string 	
--- @param cmd string 	
--- @param desc string 	
local function nmap(keymap, cmd, desc)
	map("n", keymap, "<CMD>" .. cmd .. "<CR>", { desc = desc })
end

-- Debugger
nmap("<leader>dt", "lua require('dapui').toggle()", "Toggle Debugger")
nmap("<leader>db", "DapToggleBreakpoint", "Toggle Breakpoint")
nmap("<leader>dc", "DapContinue", "Continue")
nmap("<leader>di", "DapStrpInto", "Into")
nmap("<leader>do", "DapStepOver", "Step Over")

-- Files management
nmap("<leader>fe", "lua MiniFiles.open()", "Find files")
nmap("<C-e>", "lua MiniFiles.open()", "Find files")
nmap("<leader>ff", "Pick files", "Find files")
nmap("<leader>fw", "Pick grep_live", "Find match")

-- Lsp
nmap("<S-k>", "LspUI hover", "Hover")
nmap("gd", "LspUI definition", "Declaration")
nmap("gr", "LspUI reference", "References")
nmap("ga", "LspUI code_action", "Code Actions")
nmap("<leader>gr", "LspUI rename", "Rename")
nmap("<leader>gi", "LspUI inlay_hint", "Inlay Hint")
nmap("<leader>gd", "Pick diagnostic", "Diagnostics")
nmap("<leader>gs", "lua MiniExtra.pickers.lsp({ scope = 'document_symbol' })", "Document Symbol")
nmap("<leader>gS", "lua MiniExtra.pickers.lsp({ scope = 'workspace_symbol' })", "Workspace Symbols")
-- Git
nmap('<leader>gn', "Neogit", "Neogit")

-- Buffers
nmap("<leader>bp", "BufferLinePick", "Jump to buffer")
nmap("<S-Tab>", "BufferLineCyclePrev", "Prev buffer")
nmap("<Tab>", "BufferLineCycleNext", "Next buffer")

-- Terminals
nmap("<leader>tv", "Vterm", "Vertical Terminal")
nmap("<leader>ts", "Sterm", "Horizontal Terminal")
nmap("<leader>tf", "Fterm", "Floating Terminal")

-- Completion
map('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
map('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })
