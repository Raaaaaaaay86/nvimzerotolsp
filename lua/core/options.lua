-- ## Control
vim.opt.clipboard = "unnamedplus"
vim.g.mapleader = " "

-- ## exrc
vim.o.exrc = true

-- ## Appearance
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.laststatus = 3

-- ## Spell Check
vim.opt.spell = true
vim.opt.spelllang = "en,cjk"
vim.opt.spelloptions = "camel"

-- ## Diagnostic
vim.diagnostic.config({ virtual_text = true })

-- ## File Explorer
vim.g.netrw_liststyle = 3

-- ## Editing
vim.opt.fixendofline = true
