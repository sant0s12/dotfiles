local configFiles = vim.api.nvim_create_augroup('configFiles', {})
vim.api.nvim_create_autocmd('BufWritePost', {
	pattern = '*/polybar/config',
	command = "call system('$XDG_CONFIG_HOME/polybar/launch.sh')",
	group = configFiles,
})
vim.api.nvim_create_autocmd('BufWritePost', {
	pattern = '*/i3/config',
	command = "call system('i3 restart')",
	group = configFiles,
})

vim.api.nvim_create_autocmd('CursorHold', {
	pattern = '*',
	callback = function() vim.diagnostic.open_float(nil, { focusable = false }) end,
})

--- vim.api.nvim_create_autocmd('BufWritePre', {
	---pattern = '*',
	---callback = function() vim.lsp.buf.format() end,
---})

local vimtexConfig = vim.api.nvim_create_augroup('vimtexConfig', {})
vim.api.nvim_create_autocmd('User', {
	pattern = 'VimtexEventQuit',
	command = 'call vimtex#compiler#clean(0)',
	group = vimtexConfig,
})

local lspMetals = vim.api.nvim_create_augroup('lspMetals', {})
vim.api.nvim_create_autocmd('Filetype', {
	pattern = 'scala, sbt',
	callback = function() require('metals').initialize_or_attach(metals_config) end,
	group = lspMetals,
})

-- Close term if the program run without error
vim.api.nvim_create_autocmd('TermClose', {
	pattern = '*',
	command = "if !v:event.status | exe 'bdelete! '..expand('<abuf>') | endif",
})

-- Start terminal in insert mode
vim.api.nvim_create_autocmd('TermOpen', {
	pattern = '*',
	command = 'startinsert',
})

-- Close quickfixlist on buffer close
local qfClose = vim.api.nvim_create_augroup('qfClose', {})
vim.api.nvim_create_autocmd('WinEnter', {
	pattern = '*',
	command = "if winnr('$') == 1 && &buftype == 'quickfix'|q|endif",
})
