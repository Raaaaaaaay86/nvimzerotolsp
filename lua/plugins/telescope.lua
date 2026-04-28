return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "v0.2.0",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local telescope = require("telescope")
			local telescopeConfig = require("telescope.config")

			local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
			table.insert(vimgrep_arguments, "--no-ignore-vcs")
			table.insert(vimgrep_arguments, "--hidden")
			table.insert(vimgrep_arguments, "--glob")
			table.insert(vimgrep_arguments, "!**/.git/*")
			table.insert(vimgrep_arguments, "--glob")
			table.insert(vimgrep_arguments, "!**/vendor/*")
			table.insert(vimgrep_arguments, "--glob")
			table.insert(vimgrep_arguments, "!**/target/*")
			table.insert(vimgrep_arguments, "--glob")
			table.insert(vimgrep_arguments, "!**/node_modules/*")
			table.insert(vimgrep_arguments, "--glob")
			table.insert(vimgrep_arguments, "!**/dist/*")

			telescope.setup({
				defaults = {
					vimgrep_arguments = vimgrep_arguments,
					preview = {
						treesitter = false,
					},
				},
				pickers = {
					find_files = {
						find_command = {
							"rg",
							"--files",
							"--no-ignore-vcs",
							"--hidden",
							"--glob",
							"!**/.git/*",
							"--glob",
							"!**/vendor/*",
							"--glob",
							"!**/target/*",
							"--glob",
							"!**/node_modules*",
						},
					},
				},
			})

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "search files by file's name" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Search string in CWD" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "lists open buffers" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "show help" })
			vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "show diagnostics" })
			vim.keymap.set("n", "<leader>fv", builtin.git_status, { desc = "show git status" })

			vim.keymap.set("n", "gd", builtin.lsp_definitions, {})
			vim.keymap.set("n", "gi", builtin.lsp_implementations, {})
			vim.keymap.set("n", "gR", builtin.lsp_references, {})
			vim.keymap.set("n", "go", builtin.lsp_document_symbols, {})
		end,
	},
	{
		"jmacadie/telescope-hierarchy.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		keys = {
			{ "<leader>gI", "<cmd>Telescope hierarchy incoming_calls<cr>", desc = "LSP: Incoming Calls" },
			{ "<leader>gO", "<cmd>Telescope hierarchy outgoing_calls<cr>", desc = "LSP: Outgoing Calls" },
		},
		config = function()
			require("telescope").load_extension("hierarchy")
		end,
	},
	{
		"johmsalas/text-case.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("textcase").setup({})
			require("telescope").load_extension("textcase")
		end,
		keys = {
			"ga",
			{ "ga.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "x" }, desc = "Telescope" },
		},
		cmd = { "Subs", "TextCaseOpenTelescope" },
	},
}
