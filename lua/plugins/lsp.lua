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
				ensure_installed = { "gopls", "rust_analyzer" },
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
			lspconfig.config("ts_ls",{})
			lspconfig.config("angularls",{})
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
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"onsails/lspkind.nvim",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
		},
		config = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")

			cmp.setup({
				snippet = {
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
				}, {
					{ name = "buffer" },
					{ name = "path" },
				}),
				formatting = {
					format = lspkind.cmp_format({
						with_text = true,
						maxwidth = 50,
					}),
				},
			})

			cmp.setup.cmdline("/", {
				sources = { { name = "buffer" } },
			})

			cmp.setup.cmdline(":", {
				sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
			})
		end,
	},
}
