vim.g.mapleader = " "

local map = vim.keymap.set

local opts = { noremap = false, silent = true }


-- Debugger
map("n", "<leader>dt", "<CMD>lua require('dapui').toggle()<CR>", opts, { desc = "Toggle Debugger" })
map("n", "<leader>db", "<CMD>DapToggleBreakpoint<CR>", opts, { desc = "Toggle Breakpoint" })
map("n", "<leader>dc", "<CMD>DapContinue<CR>", opts, { desc = "Continue" })
map("n", "<leader>di", "<CMD>DapStrpInto<CR>", opts, { desc = "Into" })
map("n", "<leader>do", "<CMD>DapStepOver<CR>", opts, { desc = "Over" })

-- Files management
map("n", "<leader>fe", "<CMD>:lua MiniFiles.open()<CR>", opts, { desc = "Find files" })
map("n", "<C-e>", "<CMD>:lua MiniFiles.open()<CR>", opts, { desc = "Find files" })
map("n", "<leader>ff", "<CMD>Pick files<CR>", opts, { desc = "Find files" })
map("n", "<leader>fw", "<CMD>Pick grep_live<CR>", opts, { desc = "Find match" })

-- Lsp
map("n", "<S-k>", "<CMD>LspUI hover<CR>", opts, { desc = "Hover" })
map("n", "gd", "<CMD>LspUI declaration<CR>", opts, { desc = "Declaration" })
map("n", "gr", "<CMD>LspUI reference<CR>", opts, { desc = "References" })
map("n", "ga", "<CMD>LspUI code_action<CR>", opts, { desc = "Code Actions" })
map("n", "gn", "<CMD>LspUI rename<CR>", opts, { desc = "Rename" })
map("n", "gsd", "<CMD>Pick diagnostic<CR>", opts, { desc = "Show diagnostics" })
map("n", "<C-A>", "<CMD>LspUI inlay_hint<CR>", opts, { desc = "Inlay Hint" })

-- Completion
map('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
map('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })
