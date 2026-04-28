return {
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme gruvbox]])
		end,
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				background_colour = "#50C878",
				render = "compact",
			})
		end,
	},
}
