vim.o.termguicolors = true
vim.o.errorbells = false
vim.o.smartcase = true
vim.o.showmode = false
vim.bo.swapfile = false
vim.o.backup = false
vim.o.undodir = vim.fn.stdpath('config') .. '/undodir'
vim.o.undofile = true
vim.o.incsearch = true
vim.o.hidden = true
vim.bo.autoindent = true
vim.bo.smartindent = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = 'yes'
vim.wo.wrap = false
vim.g.mapleader = ' '
vim.g.sonokai_better_performance = 1
vim.g.sonokai_diagnostic_virtual_text = 'red'
vim.cmd[[colorscheme sonokai]]
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.o.mouse = 'a'
vim.o.mousefocus = true
vim.opt.clipboard = 'unnamedplus'
vim.cmd[[syntax on]]
vim.opt.foldmethod='expr'
vim.opt.foldexpr='nvim_treesitter#foldexpr()'
vim.o.hlsearch = false
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}


