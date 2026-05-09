-- ## General
vim.keymap.set({'n', 'i', 'v'}, '<F1>', '<Esc>', { noremap = true, silent = true })

-- ## Navigation
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "scroll up and keep cursor at the middle of screen" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "scroll down and keep cursor at the middle of screen" }) -- Added based on pattern
vim.keymap.set("n", "]c", "]czz", { desc = "jump to next change" })
vim.keymap.set("n", "[c", "[czz", { desc = "jump to previous change" })

-- ## Pane Management
vim.keymap.set("n", "<leader>v", ":vsplit<CR>", { desc = "new vertical split window" })
vim.keymap.set("n", "<leader>s", ":split<CR>", { desc = "new horizontal split window" })
vim.keymap.set("n", "<leader>w", "<C-w>w", { desc = "focus on next split window" })
vim.keymap.set("n", "<A-k>", ":resize -2<CR>")
vim.keymap.set("n", "<A-j>", ":resize +2<CR>")
vim.keymap.set("n", "<A-h>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<A-l>", ":vertical resize +2<CR>")

-- ## Jump List
vim.keymap.set("n", "<C-i>", "<C-i>zz", { desc = "jump into" })
vim.keymap.set("n", "<C-o>", "<C-o>zz", { desc = "jump out" })

-- ## Mark List
vim.keymap.set("n", "<leader>fm", "<cmd>marks<CR>", { desc = "show mark list" })

-- ## Quick Fix List
vim.keymap.set("n", "<leader>ch", "<cmd>cprev<CR>zz", { desc = "go to previous quick fix list element" })
vim.keymap.set("n", "<leader>cl", "<cmd>cnext<CR>zz", { desc = "go to next quick fix list element" })

-- ## Tabs
vim.keymap.set("n", "<leader>T", ":tabedit<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>h", ":tabprevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>l", ":tabnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-L>", ":tabmove +1<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-H>", ":tabmove -1<CR>", { noremap = true, silent = true })

-- # Diagnostic
vim.keymap.set("n", "<leader>7", ":lua vim.diagnostic.goto_prev()<CR>", { desc = "go to previous diagnostic" })
vim.keymap.set("n", "<leader>8", ":lua vim.diagnostic.goto_next()<CR>", { desc = "go to next diagnostic" })

-- ## Transparency
vim.t.is_transparent = 0
local function toggle_transparent()
	if vim.t.is_transparent == 0 then
		vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
		vim.t.is_transparent = 1
	else
		vim.cmd("colorscheme gruvbox")
		vim.t.is_transparent = 0
	end
end
vim.keymap.set("n", "<F2>", toggle_transparent, { desc = "Toggle transparency" })
