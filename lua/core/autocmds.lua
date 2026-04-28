-- ## General Commands
vim.api.nvim_create_user_command(
	"Problems",
	":lua vim.diagnostic.setqflist()<CR>",
	{ desc = "Show Project Diagnostic" }
)

vim.api.nvim_create_user_command("CleanMarks", function()
	vim.cmd("delmarks [A-Z0-9]")
	print("All marks [A-Z0-9] cleared")
end, {})

-- ## Visual Selection Utilities
local function get_visual_code_selection()
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")
    local file_path = vim.fn.expand("%:p:~")
    local lines = vim.fn.getline(start_line, end_line)
    local content = table.concat(lines, "\n")
    local result = string.format("@%s :%d-%d\n\n%s", file_path, start_line, end_line, content)
    vim.fn.setreg('+', result)
    vim.fn.setreg('"', result)
    print("selected codes copied to clipboard!")
end

local function get_visual_selection_path_and_range()
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")
    local file_path = vim.fn.expand("%:p:~")
	local result = string.format("@%s :%d-%d", file_path, start_line, end_line)
    vim.fn.setreg('+', result)
    vim.fn.setreg('"', result)
    print("path copied")
end

vim.api.nvim_create_user_command('Code', get_visual_code_selection, { range = true })
vim.api.nvim_create_user_command('Line', get_visual_selection_path_and_range, { range = true })
vim.api.nvim_create_user_command("Todo", "MarksListGlobal", { desc = "Show Project Diagnostic" })
