return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		config = function()
			require("nvim-treesitter.config").setup({
				ensure_installed = { "go", "lua", "rust", "javascript", "typescript", "java", "markdown", "markdown_inline", "html" },
				auto_install = true,
				highlight = {
					enable = true,
				},
			})

			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "go", "lua", "rust", "javascript", "typescript", "java", "markdown", "markdown_inline", "html" },
				callback = function()
					vim.treesitter.start()
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = {
			enable = true,
			multiwindow = false,
			max_lines = 0,
			min_window_height = 0,
			line_numbers = true,
			multiline_threshold = 20,
			trim_scope = "outer",
			mode = "cursor",
			zindex = 20,
		},
	},
}
