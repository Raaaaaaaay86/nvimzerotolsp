return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"leoluz/nvim-dap-go",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			local dapgo = require("dap-go")

			dapui.setup({
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.40 },
							{ id = "breakpoints", size = 0.20 },
							{ id = "stacks", size = 0.20 },
							{ id = "watches", size = 0.20 },
						},
						position = "right",
						size = 40,
					},
					{
						elements = { { id = "repl", size = 1 } },
						position = "bottom",
						size = 10,
					},
					{
						elements = { { id = "console", size = 1 } },
						position = "bottom",
						size = 10,
					},
				},
				controls = { enabled = true, element = "repl" },
				floating = { border = "rounded" },
			})

			dapgo.setup({
				delve = {
					args = { "--check-go-version=false" },
					initialize_timeout_sec = 20,
				},
			})

			local js_debug = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"
			for _, adapter in ipairs({ "pwa-chrome", "chrome" }) do
				dap.adapters[adapter] = {
					type = "server",
					host = "localhost",
					port = "${port}",
					executable = {
						command = "node",
						args = { js_debug, "${port}" },
					},
				}
			end

			local angular_source_map = {
				["webpack:/*"] = "${webRoot}/*",
				["/./*"] = "${webRoot}/*",
				["/src/*"] = "${webRoot}/*",
				["/*"] = "*",
				["/./~/*"] = "${webRoot}/node_modules/*",
			}

			local angular_configs = {
				{
					type = "pwa-chrome",
					request = "launch",
					name = "Launch Chrome (Angular)",
					url = "http://localhost:4200",
					webRoot = "${workspaceFolder}",
					sourceMapPathOverrides = angular_source_map,
				},
				{
					type = "pwa-chrome",
					request = "attach",
					name = "Attach to Chrome (Angular)",
					port = 9222,
					webRoot = "${workspaceFolder}",
					sourceMapPathOverrides = angular_source_map,
				},
			}

			dap.configurations.typescript = angular_configs
			dap.configurations.javascript = angular_configs

			vim.keymap.set("n", "<F5>", dap.continue, {})
			vim.keymap.set("n", "<F17>", dap.terminate, {})
			vim.keymap.set("n", "<leader>dw", function() dapui.toggle({ layout = 1 }) end, { desc = "show breakpoints" })
			vim.keymap.set("n", "<leader>dl", function() dapui.toggle({ layout = 2 }) end, { desc = "show repl" })
			vim.keymap.set("n", "<leader>dc", function() dapui.toggle({ layout = 3 }) end, { desc = "show console" })
			vim.keymap.set("n", "<F8>", dap.toggle_breakpoint, {})
			vim.keymap.set("n", "<F9>", dap.step_over, {})
			vim.keymap.set("n", "<F10>", dap.step_into, {})
			vim.keymap.set("n", "<F22>", dap.step_out, {})

			dap.listeners.before.launch.dapui_config = function()
				dapui.toggle({ layout = 2 })
			end
		end,
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"fredrikaverpil/neotest-golang",
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-golang")({ runner = "gotestsum" }),
				},
			})

			local neotest = require("neotest")
			vim.keymap.set("n", "<leader>tn", function() neotest.run.run({}) end, { desc = "Run Nearest" })
			vim.keymap.set("n", "<leader>ta", function() neotest.run.run(vim.fn.getcwd()) end, { desc = "Run All" })
			vim.keymap.set("n", "<leader>td", function() neotest.run.run({ strategy = "dap" }) end, { desc = "Debug Nearest" })
			vim.keymap.set("n", "<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end, { desc = "Run File" })
			vim.keymap.set("n", "<leader>ts", function() neotest.summary.toggle() end, { desc = "Toggle Summary" })
			vim.keymap.set("n", "<leader>to", function() neotest.output.open({ enter = true }) end, { desc = "Show Output" })
		end,
	},
}
