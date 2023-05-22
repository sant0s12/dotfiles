vim.opt.autoindent 		= true
vim.opt.smartindent 	= true
vim.opt.tabstop 		= 4
vim.opt.shiftwidth		= 4

vim.opt.number 			= true
vim.opt.relativenumber 	= true

vim.opt.incsearch 		= true
vim.opt.hlsearch 		= false
vim.opt.ignorecase		= true
vim.opt.smartcase 		= true
vim.opt.showmatch 		= false

vim.opt.backup 			= false
vim.opt.swapfile		= false
vim.opt.undofile 		= true

vim.opt.termguicolors 	= true

vim.opt.autochdir 		= true
vim.opt.listchars		= ""
vim.opt.clipboard		= "unnamedplus"
vim.opt.errorbells 		= false
vim.opt.mouse			= "a"
vim.opt.updatetime		= 50

vim.opt.scrolloff		= 8
vim.opt.textwidth		= 100
vim.opt.colorcolumn		= "100"

vim.opt.completeopt		= {'menu', 'menuone', 'noselect'}

vim.g.mapleader = ' '

-- Avoid showing extra messages when using completion
vim.opt.shortmess:append("c")
-- For scala metals
vim.opt.shortmess:append("F")
