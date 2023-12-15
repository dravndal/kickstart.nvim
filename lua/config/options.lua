vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.clipboard = 'unnamedplus'
vim.opt.pumheight = 10
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.breakindent = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.signcolumn = "yes"
vim.opt.belloff = "all"

vim.opt.formatoptions = vim.opt.formatoptions
	- "a"
	- "t"
	+ "c"
	+ "q"
	- "o"
	+ "r"
	+ "n"
	+ "j"
	- "2"

vim.o.hlsearch = false
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.mouse = "a"
vim.o.scrolloff = 10
vim.o.undofile = true
vim.o.updatetime = 100
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.completeopt = 'menu,menuone,noinsert'
vim.o.termguicolors = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.cmdheight = 0
vim.opt.expandtab = true
vim.g.netrw_liststyle=3

-- custom globals
vim.g.skip_ts_context_commentstring_module = true
