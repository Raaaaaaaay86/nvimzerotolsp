return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "gopls", "rust_analyzer", "ts_ls", "vue_ls" },
				automatic_enable = {
					exclude = { "jdtls" },
				},
			})

			local function get_go_module_name()
				local mod_file = vim.fn.getcwd() .. "/go.mod"
				local f = io.open(mod_file, "r")
				if f then
					local content = f:read("*l")
					f:close()
					if content then
						return content:match("module%s+(%S+)")
					end
				end
				return nil
			end

			local lspconfig = vim.lsp
			-- General LSPs
			lspconfig.config("stylua",{})
			local vue_plugin_path = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
			lspconfig.config("ts_ls", {
				init_options = {
					plugins = {
						{
							name = "@vue/typescript-plugin",
							location = vue_plugin_path,
							languages = { "vue" },
						},
					},
				},
				filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
			})
			lspconfig.config("angularls", {})
			lspconfig.config("vue_ls", {
				init_options = {
					vue = { hybridMode = true },
				},
			})
			lspconfig.config("html",{})
			lspconfig.config("gopls",{
				settings = {
					gopls = {
						["local"] = get_go_module_name() or "",
						gofumpt = true,
					},
				},
			})
			lspconfig.config("golangci_lint_ls",{
				cmd = { "golangci-lint-langserver" },
				init_options = {
					command = {
						"golangci-lint-v2",
						"run",
						"--fast-only",
						"--output.json.path",
						"stdout",
						"--show-stats=false",
						"--issues-exit-code=1",
					},
				},
			})

			-- LSP Keymaps
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local opts = { buffer = args.buf, silent = true, noremap = true }
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<leader>fc", vim.lsp.buf.format, opts)
					vim.keymap.set("n", "gh", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "ge", vim.diagnostic.open_float, opts)
				end,
			})
		end,
	},
	{
		"saghen/blink.cmp",
		dependencies = {
			"saghen/blink.lib",
			"rafamadriz/friendly-snippets",
		},
		build = function()
			require("blink.cmp").build():wait(60000)
		end,
		opts = {
			keymap = {
				preset = "enter",
				["<C-k>"] = {},
			},
			completion = { documentation = { auto_show = false } },
			sources = { default = { "lsp", "path", "snippets", "buffer" } },
			fuzzy = { implementation = "rust" },
		},
	},
}
