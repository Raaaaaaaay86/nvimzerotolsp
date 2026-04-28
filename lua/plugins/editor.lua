return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({
				window = { position = "right" },
				filesystem = {
					filtered_items = { visible = true, hide_dotfiles = false },
				},
			})
			vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle neo-tree" })
			vim.keymap.set("n", "<leader>bf", ":Neotree filesystem<CR>", { desc = "Toggle neo-tree filesystem" })
			vim.keymap.set("n", "<leader>bg", ":Neotree git_status<CR>", { desc = "Toggle neo-tree git status" })
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				on_attach = function(buffer)
					local gs = package.loaded.gitsigns
					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = buffer
						vim.keymap.set(mode, l, r, opts)
					end
					-- Navigation
					map("n", "]c", function()
						if vim.wo.diff then return "]c" end
						vim.schedule(function() gs.next_hunk() end)
						return "<Ignore>"
					end, { expr = true })
					map("n", "[c", function()
						if vim.wo.diff then return "[c" end
						vim.schedule(function() gs.prev_hunk() end)
						return "<Ignore>"
					end, { expr = true })
				end,
			})
		end,
	},
	{
		"ThePrimeagen/harpoon",
		config = function()
			local ui = require("harpoon.ui")
			local mark = require("harpoon.mark")
			vim.keymap.set("n", "<leader>k", ui.nav_prev)
			vim.keymap.set("n", "<leader>j", ui.nav_next)
			vim.keymap.set("n", "<leader>fa", ui.toggle_quick_menu)
			vim.keymap.set("n", "<leader>a", mark.add_file)
		end,
	},
}
